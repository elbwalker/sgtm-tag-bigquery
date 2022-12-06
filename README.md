# sgtm-tag-bigquery
send walker.js events from ssGTM to BigQuery

# Important Note
this is a preview release of the *walker.js to BigQuery* tag template for server-side GTM. It uses the `x-elb-event` key in the server-side event model that usually gets populated by handling incoming walker.js events with the [walker.js Custom Client Template for server-side GTM](https://github.com/elbwalker/sgtm-client-template). 

## Creating a BigQuery Table For walker.js Events
The BigQuery table that this tag template expects has a similar structure to all walker.js events - incuding entity, action, data, context, nested, version, timestamp, group and everything else specified in the [elbwalker website](https://www.elbwalker.com/). A `server_timestamp` is added as an alternative to the existing `timestamp` information from the browser. 

Additionally, you can define a set of key / value pairs that get sent along with the walker.js event and get stored in a `additional_params` record. Values will be available as `string_value`, `float_value` or `int_value`. You can use them to add a user-defined set of headers, cookies or attributes of the request or event. 

### Schema
Create a new table in a new or existing dataset with the following schema that can be pasted as JSON: 

**Note**: There is an option to store additional parameters in the BQ table in two different ways:
 
- store additional parameters as JSON
- store additional parameters as RECORD

The default is JSON, since all other objects inside a walker.js event end up a JSON field as well. If you want to use a record instead, change the field definition for `additional_params` like described below. 

```
[
    {
        "name": "timestamp",
        "type": "INTEGER",
        "mode": "REQUIRED",
        "description": "walker event timestamp"
    },
    {
        "name": "event",
        "type": "STRING",
        "mode": "REQUIRED",
        "description": "Event name as entity and action"
    },
    {
        "name": "data",
        "type": "JSON",
        "mode": "NULLABLE",
        "description": "All entity properties"
    },
    {
        "name": "context",
        "type": "JSON",
        "mode": "NULLABLE",
        "description": "The context object"
    },
    {
        "name": "globals",
        "type": "JSON",
        "mode": "NULLABLE",
        "description": "All global context properties set"
    },
    {
        "name": "user",
        "type": "RECORD",
        "mode": "NULLABLE",
        "description": "Information about the user",
        "fields": [
            {
                "name": "hash",
                "type": "STRING",
                "mode": "NULLABLE",
                "description": "session value (e.g. encrypted temporary fingerprint)"
            },
            {
                "name": "device",
                "type": "STRING",
                "mode": "NULLABLE",
                "description": "The user's cookie id"
            },
            {
                "name": "id",
                "type": "STRING",
                "mode": "NULLABLE",
                "description": "The user's hashed id"
            }
        ]
    },
    {
        "name": "nested",
        "type": "JSON",
        "mode": "NULLABLE",
        "description": "All nested entities within the mother entity"
    },
    {
        "name": "consent",
        "type": "JSON",
        "mode": "NULLABLE",
        "description": "The user's consent states for the event (analytics, marketing)"
    },
    {
        "name": "id",
        "type": "STRING",
        "mode": "REQUIRED",
        "description": "Identifier out of timestamp, group & count of the event"
    },
    {
        "name": "entity",
        "type": "STRING",
        "mode": "REQUIRED",
        "description": "Name of the entity"
    },
    {
        "name": "action",
        "type": "STRING",
        "mode": "REQUIRED",
        "description": "Name of the action"
    },
    {
        "name": "trigger",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "Name of the trigger that fired an event"
    },
    {
        "name": "timing",
        "type": "FLOAT",
        "mode": "NULLABLE",
        "description": "Seconds that have passed since initialization until the event occurs"
    },
    {
        "name": "group",
        "type": "STRING",
        "mode": "REQUIRED",
        "description": "Random group id for all events on a page"
    },
    {
        "name": "count",
        "type": "INTEGER",
        "mode": "REQUIRED",
        "description": "Incremental counter of the events on a page"
    },
    {
        "name": "version",
        "type": "RECORD",
        "mode": "NULLABLE",
        "description": "Used versions for event collection",
        "fields": [
            {
                "name": "config",
                "type": "STRING",
                "mode": "REQUIRED",
                "description": "The tagging configuration used on the client-side"
            },
            {
                "name": "walker",
                "type": "STRING",
                "mode": "REQUIRED",
                "description": "The used walker.js version on the client-side"
            },
            {
                "name": "server",
                "type": "STRING",
                "mode": "NULLABLE",
                "description": "version of the sending tag on the server-side"
            }
        ]
    },
    {
        "name": "source",
        "type": "RECORD",
        "mode": "NULLABLE",
        "description": "Origins of the event",
        "fields": [
            {
                "name": "type",
                "type": "STRING",
                "mode": "NULLABLE",
                "description": "Source type of the event"
            },
            {
                "name": "id",
                "type": "STRING",
                "mode": "NULLABLE",
                "description": "Source id of the event's origin"
            },
            {
                "name": "previous_id",
                "type": "STRING",
                "mode": "NULLABLE",
                "description": "Previous source id of the event's origin"
            }
        ]
    },
    {
        "name": "server_timestamp",
        "type": "INTEGER",
        "mode": "REQUIRED",
        "description": "Timestamp when the sGTM processed the event in ms"
    },
    {
        "name": "additional_params",
        "type": "JSON",
        "mode": "NULLABLE",
        "description": "Optionally captured but relevant event information in addition"
    }
]

```

if you prefer a RECORD over JSON, swap out the definition for `additional_params` and use this block instead: 

```
  {
    "name": "additional_params",
    "mode": "REPEATED",
    "type": "RECORD",
    "description": "Optionally captured but relevant event information in addition",
    "fields": [
      {
        "name": "key",
        "mode": "NULLABLE",
        "type": "STRING",
        "fields": []
      },
      {
        "name": "value",
        "mode": "NULLABLE",
        "type": "RECORD",
        "fields": [
          {
            "name": "string_value",
            "mode": "NULLABLE",
            "type": "STRING"
          },
          {
            "name": "float_value",
            "mode": "NULLABLE",
            "type": "STRING"
          },
          {
            "name": "int_value",
            "mode": "NULLABLE",
            "type": "STRING"
          }
        ]
      }
    ]
  }

```

### Partitioning
Depending on your use case you should consider partitioning. The example SQL queries can be used with either  version and has to be adjusted to use the proper project / table name anyway. If you prefer to use a timestamp instead of ingestion time, prefer `server_timestamp` over the browser `timestamp` to use a common time base for all events.  

## Using The Tag Template
- add the template to your ssGTM in the *templates" section as a new tag template by creating a new template and importing this `.tpl` file (use the three-dot-menu in GTM Template Editor). 

- Add a new tag to ssGTM with this template and enter **project id** (if using a different project), **database id** and **table id**. #

- Incoming walker.js events originate from the `x-elb-event` key in the event model if you keep the *Event Source* setting on *Automatic*. In case a different type of client is used or enhanced event processing inside a custom variable before sending data to BigQuery is required, use a *Custom Variable* as source.  

- The tag can optionally add additional parameters (like IP address, user agent, headers, cookie values or others) to the BigQuery table in a   `additional_params` record. 

![image](https://user-images.githubusercontent.com/15323700/205728127-5294143f-33df-498e-967e-13670fea0c28.png)

- Send events to your endpoint like demonstrated in the [example code from the ssGTM client repository](https://github.com/elbwalker/sgtm-client-template/tree/main/example) or use a client-side GTM and install the [walker.js Event Custom Tag Template](https://github.com/elbwalker/sgtm-client-template). Trigger your walker.js to BigQuery tag whenever a walker.js event arrives. 

## BigQuery Results
All Events will get pushed to the new table in BigQuery. Data like `globals`, `data`, `context`, `nested` and other objects will be stored in JSON fields and can be accessed in different ways. You can use `JSON_EXTRACT` as well as simply access nested information in a JSON field by using dot notation. The following query shows how to extract selected fields using both methods and creating a simple "GA like" list of all page view events. 

```
SELECT
  timestamp AS event_timestamp,
  "page_view" AS event_name,
  JSON_VALUE(data.domain) AS page_hostname,
  JSON_VALUE(DATA["title"]) AS page_title,
  JSON_VALUE(DATA["id"]) AS page_path,
  JSON_VALUE(JSON_EXTRACT(user, "$.hash")) AS client_id, /* optinally use JSON_EXTRACT instead of dot notation */
  JSON_VALUE(user.device) AS ga_session_id,
FROM
  `YourProjectId.YourDatabaseId.YourTableId`
WHERE
  event = "page view"
LIMIT
  100
```

The results should look similar to this: 

![image](https://user-images.githubusercontent.com/15323700/205689109-7b69dbd1-32b5-4bab-b6a2-5200b1cc5812.png)
