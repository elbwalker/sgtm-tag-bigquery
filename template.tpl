___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "walker.js Events to BigQuery",
  "categories": [
    "ANALYTICS"
  ],
  "brand": {
    "id": "mbaersch",
    "displayName": "mbaersch",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAYCAYAAACbU/80AAAABmJLR0QAvgD/ALe9KR/IAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH5gseEAEKLjc4rQAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAAMSSURBVEjH1VZLSJRRFP7O/f9hMoqMYoasGBOpaFNhSIvohSA12juSorIHahKJLaRVm6BAKiQj8gGJEC6KQJ0BLUjalIsgadVLZ4wk/ikpSR0dnXtaKGYzZ/75d9Fdnu+e8333nHPPvcA/XuR0o6cztJiUug6iEgDL5wDm3Zbf12Pn6w2GNwFUB6KtANyzfl8sv2+16ZA8gwyjB0DeXwBzH0fHXtiSB0K7QKobgCsBqgUA5ShNhnEliXxm1UeObNApyTsHCKSaBfIx1vFWRwI87Z8WADgnQF/1RLTNXjkdAFFOkp25IVKcM+JIAJmukwBWCkFavh1eH7V1VkaVYNUA189tcVCBMsE2zvH4bdvadwxsBrBDEN5u+bPDjgR4g4MFINoiBHkU2Zfz3Va2YVSnQG7+laQ0p5dTyFyX5totBdFRQfhby+976UiANziYC6K9AvTcKsruSyO8BsACwX4jqU1sglSKuNZ37O992AVSZ5IRHgbwxJEAbyCcCaJyAfrAU7FAmtOfBeAV0l9n+X2xRLOZ4v6eBrBQCHI/cnAte4Ph7QBVAygEeDYz3GUVrzkEpS4IESdBqsHRW+Bp7zfJND+DaEUC+y+enMwil+swlNEiiPOD9RSU8VTAmiy/r0wcFcmDx9yTTA6A0QTTZUIZ9QJBSP8Y7oJSVWJGmRtTzirBdlUKAa1vk1IXASwW8FtqydJcgAoF12dWUfZrRwK8gXBeisHTbhWvGQLhvEAwDq0fQqlLYk9pvms7rROa73KKFNZ6AqHjAPmE3NxjsALRCcHvnR4dCTgS4OnozwLRMSHIG6so+xUp44xYGuYHZJinAGQK+L1vJRu1nQDzz5tvVgIwhD213s7QZgAFgrguAJ/A3A1KulDfOTbxIN1LZwKA58n7DBBVCARDHI8/JtNoTFGaOyAqBtEqAWuNHFw36kgAud2lAJYJeDmIMgHxYWnjWKyb3O5ewe8jT09dc/LbmukBUhUJwXvBeqfl9wVJqUoAi+ahEbCu4eh4Kbnd+SDKn/9PAHMzpqe3Rfbn/sT/sH4DfEUaJgR8khoAAAAASUVORK5CYII\u003d"
  },
  "description": "sends walker.js event structure to BigQuery",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "groupBq",
    "displayName": "BigQuery Settings",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "LABEL",
        "name": "labelBq",
        "displayName": "This tag requires an existing table with a pre-defined structure. You can copy the schema from https://github.com/elbwalker/sgtm-tag-bigquery#readme"
      },
      {
        "type": "TEXT",
        "name": "projectId",
        "displayName": "Project ID",
        "simpleValueType": true,
        "help": "Project ID is required in case the BigQuery database does not belong to the ssGTM container project."
      },
      {
        "type": "TEXT",
        "name": "datasetId",
        "displayName": "Dataset ID",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "tableId",
        "displayName": "Table ID",
        "simpleValueType": true
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupEventSource",
    "displayName": "Event Source",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "eventSource",
        "displayName": "",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "auto",
            "displayValue": "Automatic"
          },
          {
            "value": "variable",
            "displayValue": "Custom Variable"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "auto"
      },
      {
        "type": "TEXT",
        "name": "eventSourceVar",
        "displayName": "Event Source Variable",
        "simpleValueType": true,
        "enablingConditions": [
          {
            "paramName": "eventSource",
            "paramValue": "variable",
            "type": "EQUALS"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupVersion",
    "displayName": "Server Versions",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "serverVersions",
        "displayName": "Version Information",
        "simpleValueType": true,
        "help": "Optionally enter versioning for the configuration of your server-side client and / or tag.",
        "defaultValue": "1.0 / 1.0"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupParams",
    "displayName": "Add Additional Data",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "LABEL",
        "name": "labelInfo",
        "displayName": "You can add additional data to every event. Define key and value pairs using variables that contain event data, headers or any other information. All additional information will be added to the \"additional_data\" field in BigQuery."
      },
      {
        "type": "PARAM_TABLE",
        "name": "addParams",
        "displayName": "",
        "paramTableColumns": [
          {
            "param": {
              "type": "TEXT",
              "name": "key",
              "displayName": "Key",
              "simpleValueType": true
            },
            "isUnique": true
          },
          {
            "param": {
              "type": "TEXT",
              "name": "value",
              "displayName": "Value",
              "simpleValueType": true
            },
            "isUnique": false
          }
        ]
      },
      {
        "type": "SELECT",
        "name": "paramsFieldType",
        "displayName": "Format / Type",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "json",
            "displayValue": "JSON"
          },
          {
            "value": "record",
            "displayValue": "RECORD"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "json",
        "help": "Pick a field type for the \"additional_data\" field containing any added information. Must match the schema in your BigQuery table."
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

/**
 * @description Custom server-side Google Tag Manager Tag Template 
 * Sending walker.js events to BigQuery
 * @version 0.2.1
 * @see {@link https://github.com/elbwalker|elbwalker on GitHub} for more about walker.js
 */

const JSON = require('JSON');
const BigQuery = require('BigQuery');
const getAllEventData = require('getAllEventData');
const getTimestampMillis = require('getTimestampMillis');
const makeInteger = require('makeInteger');

/**
 * defines record target field for any value.
 * @param {*} val - any value to map to a target record field.
 */
const getBqRecordType = function(val) {
  switch (typeof(val)) {
    case 'number': return (makeInteger(val) === val) ? 
                      'int_value' : 'float_value';     
    case 'boolean': return 'int_value'; 
    default: return 'string_value';
  }  
};

/**
 * converts value for record target fields. Converts bool to int and objects to JSON strings 
 * @param {*} val - any value to convert map to a record field value.
 */
const getBqRecordValue = function(val){
  if (typeof(val) === 'object' && val !== null) return JSON.stringify(val);
  if (typeof(val) === 'boolean') return val ? 1 : 0;
  return val;
};

/****************************************************************/

let bigQueryObject;

if (data.eventSource === "auto") {
  const elbEvent = getAllEventData();
  bigQueryObject = elbEvent["x-elb-event"];
} else 
  bigQueryObject = data.eventSourceVar;

if (!bigQueryObject) {
  require("logToConsole")("ERROR: no walker event (x-elb-event) received!");
  data.gtmOnFailure();
} else {
  //add timestamp, server versions and convert JSON field values
  bigQueryObject.server_timestamp = getTimestampMillis();
  bigQueryObject.data = JSON.stringify(bigQueryObject.data);
  bigQueryObject.context = JSON.stringify(bigQueryObject.context);
  if (bigQueryObject.consent)
    bigQueryObject.consent = JSON.stringify(bigQueryObject.consent);
  if (bigQueryObject.custom)
    bigQueryObject.custom = JSON.stringify(bigQueryObject.custom);
  bigQueryObject.globals = JSON.stringify(bigQueryObject.globals);
  bigQueryObject.nested = JSON.stringify(bigQueryObject.nested);  
  if (data.serverVersions && bigQueryObject.version) 
    bigQueryObject.version.server = data.serverVersions;
  
  //adjust user for events < walker.js 1.6
  if (bigQueryObject.user && bigQueryObject.user.hash) 
    bigQueryObject.user.session = bigQueryObject.user.hash;

  //adjust version for events >= walker.js 2.x to fit new db schema 
  //and older events for new schema
  if (bigQueryObject.version && !bigQueryObject.version.walker && bigQueryObject.version.client) {
    bigQueryObject.version.walker = bigQueryObject.version.client;
    bigQueryObject.version.config = bigQueryObject.version.tagging;
  } else if (bigQueryObject.version && !bigQueryObject.version.client && bigQueryObject.version.walker) {
    bigQueryObject.version.client = bigQueryObject.version.walker;
    bigQueryObject.version.tagging = bigQueryObject.version.config;
  }
  
  // add additional data fields to BigQuery params JSON or record
  if (data.addParams && data.addParams.length > 0) {
    let additionalParamsArray = [], 
        additionalParamsObj = {};
    data.addParams.forEach(x => {      
      let val = x.value;
      if (val) {
        if (data.paramsFieldType === 'json') 
          additionalParamsObj[x.key] = val;
        else {
          const param = {
            key: x.key,
            value: {}
          };    
          param.value[getBqRecordType(val)] = getBqRecordValue(val);
          additionalParamsArray.push(param);
        }  
      }  
    });

    bigQueryObject.additional_data = (data.paramsFieldType === 'json') ? JSON.stringify(additionalParamsObj) : additionalParamsArray;
  }
  
  //send event row to BQ
  BigQuery.insert(
    {
      projectId: data.projectId,
      datasetId: data.datasetId,
      tableId: data.tableId
    }, 
    [bigQueryObject], 
    {ignoreUnknownValues: true}, 
    data.gtmOnSuccess, 
    data.gtmOnFailure);
}


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_bigquery",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedTables",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "projectId"
                  },
                  {
                    "type": 1,
                    "string": "datasetId"
                  },
                  {
                    "type": 1,
                    "string": "tableId"
                  },
                  {
                    "type": 1,
                    "string": "operation"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "*"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 04/03/2021, 10:54:54


