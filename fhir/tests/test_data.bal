// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com).

// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

final json & readonly testCapabilityStatementJson = {
    "resourceType": "CapabilityStatement",
    "id": "2e5c7f65-eb3e-495c-9f04-e949b2d9e7cc",
    "status": "active",
    "implementation": {
        "description": "HAPI FHIR Test/Demo Server R4 Endpoint",
        "url": "http://localhost:8080/fhir_test_server/r4"
    },
    "fhirVersion": "4.0.1",
    "format": ["application/fhir+xml", "xml", "application/fhir+json", "json"],
    "patchFormat": ["application/json-patch+json", "application/xml-patch+xml"],
    "rest": [
        {
            "mode": "server",
            "resource": [
                {
                    "type": "Account",
                    "profile": "http://hl7.org/fhir/StructureDefinition/Account",
                    "interaction": [
                        {
                            "code": "search-type"
                        }
                    ],
                    "searchInclude": ["*"],
                    "searchParam": [
                        {
                            "name": "identifier",
                            "definition": "http://hl7.org/fhir/SearchParameter/Account-identifier",
                            "type": "token",
                            "documentation": "Account number"
                        }
                    ],
                    "operation": [
                        {
                            "name": "validate",
                            "definition": "http://localhost:8080/fhir_test_server/r4/OperationDefinition/Multi-it-validate"
                        }
                    ]
                },
                {
                    "type": "ActivityDefinition",
                    "profile": "http://hl7.org/fhir/StructureDefinition/ActivityDefinition",
                    "versioning": "versioned-update",
                    "operation": [
                        {
                            "name": "validate",
                            "definition": "http://localhost:8080/fhir_test_server/r4/OperationDefinition/Multi-it-validate"
                        }
                    ]
                }
            ],
            "interaction": [
                {
                    "code": "transaction"
                }
            ],
            "operation": [
                {
                    "name": "diff",
                    "definition": "http://localhost:8080/fhir_test_server/r4/OperationDefinition/Global-is-diff",
                    "documentation": "This operation examines two resource versions (can be two versions of the same resource, or two different resources) and generates a FHIR Patch document showing the differences."
                }
            ]
        }
    ]
};

final json & readonly testCapabilityStatementJsonUrlRewritten = {
    "resourceType": "CapabilityStatement",
    "id": "2e5c7f65-eb3e-495c-9f04-e949b2d9e7cc",
    "status": "active",
    "implementation": {
        "description": "HAPI FHIR Test/Demo Server R4 Endpoint",
        "url": "http://localhost:8181/fhir"
    },
    "fhirVersion": "4.0.1",
    "format": ["application/fhir+xml", "xml", "application/fhir+json", "json"],
    "patchFormat": ["application/json-patch+json", "application/xml-patch+xml"],
    "rest": [
        {
            "mode": "server",
            "resource": [
                {
                    "type": "Account",
                    "profile": "http://hl7.org/fhir/StructureDefinition/Account",
                    "interaction": [
                        {
                            "code": "search-type"
                        }
                    ],
                    "searchInclude": ["*"],
                    "searchParam": [
                        {
                            "name": "identifier",
                            "definition": "http://hl7.org/fhir/SearchParameter/Account-identifier",
                            "type": "token",
                            "documentation": "Account number"
                        }
                    ],
                    "operation": [
                        {
                            "name": "validate",
                            "definition": "http://localhost:8181/fhir/OperationDefinition/Multi-it-validate"
                        }
                    ]
                },
                {
                    "type": "ActivityDefinition",
                    "profile": "http://hl7.org/fhir/StructureDefinition/ActivityDefinition",
                    "versioning": "versioned-update",
                    "operation": [
                        {
                            "name": "validate",
                            "definition": "http://localhost:8181/fhir/OperationDefinition/Multi-it-validate"
                        }
                    ]
                }
            ],
            "interaction": [
                {
                    "code": "transaction"
                }
            ],
            "operation": [
                {
                    "name": "diff",
                    "definition": "http://localhost:8181/fhir/OperationDefinition/Global-is-diff",
                    "documentation": "This operation examines two resource versions (can be two versions of the same resource, or two different resources) and generates a FHIR Patch document showing the differences."
                }
            ]
        }
    ]
};

final xml & readonly testCapabilityStatementXml = xml `<CapabilityStatement xmlns="http://hl7.org/fhir">
	<id>2e5c7f65-eb3e-495c-9f04-e949b2d9e7cc</id>
	<status>active</status>
	<implementation>
		<description>HAPI FHIR Test/Demo Server R4 Endpoint</description>
		<url>http://localhost:8080/fhir_test_server/r4</url>
	</implementation>
	<fhirVersion>4.0.1</fhirVersion>
	<format>application/fhir+xml</format>
	<format>xml</format>
	<format>application/fhir+json</format>
	<format>json</format>
	<patchFormat>application/json-patch+json</patchFormat>
	<patchFormat>application/xml-patch+xml</patchFormat>
	<rest>
		<mode>server</mode>
		<resource>
			<type>Account</type>
			<profile>http://hl7.org/fhir/StructureDefinition/Account</profile>
			<interaction>
				<code>search-type</code>
			</interaction>
			<searchInclude>*</searchInclude>
			<searchParam>
				<name>identifier</name>
				<definition>http://hl7.org/fhir/SearchParameter/Account-identifier</definition>
				<type>token</type>
				<documentation>Account number</documentation>
			</searchParam>
			<operation>
				<name>validate</name>
				<definition>http://localhost:8080/fhir_test_server/r4/OperationDefinition/Multi-it-validate</definition>
			</operation>
		</resource>
		<resource>
			<type>ActivityDefinition</type>
			<profile>http://hl7.org/fhir/StructureDefinition/ActivityDefinition</profile>
			<versioning>versioned-update</versioning>
			<operation>
				<name>validate</name>
				<definition>http://localhost:8080/fhir_test_server/r4/OperationDefinition/Multi-it-validate</definition>
			</operation>
		</resource>
		<interaction>
			<code>transaction</code>
		</interaction>
		<operation>
			<name>diff</name>
			<definition>http://localhost:8080/fhir_test_server/r4/OperationDefinition/Global-is-diff</definition>
			<documentation>This operation examines two resource versions (can be two versions of the same resource, or two different resources) and generates a FHIR Patch document showing the differences.</documentation>
		</operation>
	</rest>
</CapabilityStatement>`;

final xml & readonly testCapabilityStatementXmlUrlRewritten = xml `<CapabilityStatement xmlns="http://hl7.org/fhir">
	<id>2e5c7f65-eb3e-495c-9f04-e949b2d9e7cc</id>
	<status>active</status>
	<implementation>
		<description>HAPI FHIR Test/Demo Server R4 Endpoint</description>
		<url>http://localhost:8181/fhir</url>
	</implementation>
	<fhirVersion>4.0.1</fhirVersion>
	<format>application/fhir+xml</format>
	<format>xml</format>
	<format>application/fhir+json</format>
	<format>json</format>
	<patchFormat>application/json-patch+json</patchFormat>
	<patchFormat>application/xml-patch+xml</patchFormat>
	<rest>
		<mode>server</mode>
		<resource>
			<type>Account</type>
			<profile>http://hl7.org/fhir/StructureDefinition/Account</profile>
			<interaction>
				<code>search-type</code>
			</interaction>
			<searchInclude>*</searchInclude>
			<searchParam>
				<name>identifier</name>
				<definition>http://hl7.org/fhir/SearchParameter/Account-identifier</definition>
				<type>token</type>
				<documentation>Account number</documentation>
			</searchParam>
			<operation>
				<name>validate</name>
				<definition>http://localhost:8181/fhir/OperationDefinition/Multi-it-validate</definition>
			</operation>
		</resource>
		<resource>
			<type>ActivityDefinition</type>
			<profile>http://hl7.org/fhir/StructureDefinition/ActivityDefinition</profile>
			<versioning>versioned-update</versioning>
			<operation>
				<name>validate</name>
				<definition>http://localhost:8181/fhir/OperationDefinition/Multi-it-validate</definition>
			</operation>
		</resource>
		<interaction>
			<code>transaction</code>
		</interaction>
		<operation>
			<name>diff</name>
			<definition>http://localhost:8181/fhir/OperationDefinition/Global-is-diff</definition>
			<documentation>This operation examines two resource versions (can be two versions of the same resource, or two different resources) and generates a FHIR Patch document showing the differences.</documentation>
		</operation>
	</rest>
</CapabilityStatement>`;

// get resource data
final json & readonly testGetResourceDataJson = {
    "resourceType": "Patient",
    "id": "pat1",
    "meta": {
        "versionId": "107",
        "lastUpdated": "2022-07-21T16:20:34.870+00:00",
        "source": "#k3Fk63xjKuw2SndM"
    },
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">\n<table class=\"hapiPropertyTable\">\n<tbody>\n<tr>\n<td>Identifier</td>\n                        <td/>\n                    </tr>\n                </tbody>\n            </table>\n        </div>"
    },
    "identifier": [
        {
            "type": {
                "coding": [
                    {
                        "system": "http://hl7.org/fhir/v2/0203",
                        "code": "MR"
                    }
                ]
            },
            "value": "37b847a5-7e5b-439e-9adf-c325f0c837c9"
        }
    ],
    "name": [
        {
            "use": "official",
            "text": "Eve Everygiard",
            "family": "Eve",
            "given": [
                "Everywomen"
            ]
        },
        {
            "family": "Brown",
            "given": [
                "Carla"
            ]
        }
    ],
    "gender": "female",
    "birthDate": "1980-06-10"
};

final xml & readonly testGetResourceDataXml = xml `<Patient xmlns="http://hl7.org/fhir">
    <id value="5"/>
    <meta>
        <versionId value="107"/>
        <lastUpdated value="2022-07-21T16:20:34.870+00:00"/>
        <source value="#k3Fk63xjKuw2SndM"/>
    </meta>
    <text>
        <status value="generated"/>
        <div xmlns="http://www.w3.org/1999/xhtml">
            <table class="hapiPropertyTable">
                <tbody>
                    <tr>
                        <td>Identifier</td>
                        <td/>
                    </tr>
                </tbody>
            </table>
        </div>
    </text>
    <identifier>
        <type>
            <coding>
                <system value="http://hl7.org/fhir/v2/0203"/>
                <code value="MR"/>
            </coding>
        </type>
        <value value="37b847a5-7e5b-439e-9adf-c325f0c837c9"/>
    </identifier>
    <name>
        <use value="official"/>
        <text value="Eve Everygiard"/>
        <family value="Eve"/>
        <given value="Everywomen"/>
    </name>
    <name>
        <family value="Brown"/>
        <given value="Carla"/>
    </name>
    <gender value="female"/>
    <birthDate value="1980-06-10"/>
</Patient>`;

final json & readonly testGetResourceFailedData = {
    "resourceType": "OperationOutcome",
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h1>Operation Outcome</h1><table border=\"0\"><tr><td style=\"font-weight: bold;\">ERROR</td><td>[]</td><td><pre>HAPI-0935: Resource with ID 500 exists but it is not of type Patient, found resource of type Observation</pre></td>\n\t\t\t</tr>\n\t\t</table>\n\t</div>"
    },
    "issue": [
        {
            "severity": "error",
            "code": "processing",
            "diagnostics": "HAPI-0935: Resource with ID 500 exists but it is not of type Patient, found resource of type Observation"
        }
    ]
};

final json & readonly testDeleteResourceFailedData = {
    "resourceType": "OperationOutcome",
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h1>Operation Outcome</h1><table border=\"0\"><tr><td style=\"font-weight: bold;\">INFORMATION</td><td>[]</td><td><pre>Successfully deleted 1 resource(s) in 0ms</pre></td>\n\t\t\t</tr>\n\t\t</table>\n\t</div>"
    },
    "issue": [
        {
            "severity": "error",
            "code": "informational",
            "diagnostics": "resource doesn't exists"
        }
    ]
};

final json & readonly testUpdateResourceDataJson = {
    "resourceType": "Patient",
    "id": "pat1",
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><table class=\"hapiPropertyTable\"><tbody><tr><td>Identifier</td><td/></tr></tbody></table></div>"
    },
    "identifier": [
        {
            "type": {
                "coding": [
                    {
                        "system": "http://hl7.org/fhir/v2/0203",
                        "code": "MR"
                    }
                ]
            },
            "value": "37b847a5-7e5b-439e-9adf-c325f0c837c9"
        }
    ],
    "name": [
        {
            "use": "official",
            "text": "Eve Everygiard",
            "family": "Eve",
            "given": [
                "Everywomen"
            ]
        }
    ],
    "gender": "female",
    "birthDate": "1980-06-10",
    "address": [
        {
            "use": "home",
            "type": "both",
            "text": "Gesundheitsallee 12 in 44137 Dortmund",
            "line": [
                "Gesundheitsallee 12"
            ],
            "city": "Dortmund",
            "postalCode": "44137"
        }
    ]
};

final xml & readonly testUpdateResourceDataXml = xml `<Patient xmlns="http://hl7.org/fhir">
    <id value="pat1"/>
    <text>
        <status value="generated"/>
        <div xmlns="http://www.w3.org/1999/xhtml">
            <table class="hapiPropertyTable">
                <tbody>
                    <tr>
                        <td>Identifier</td>
                        <td/>
                    </tr>
                </tbody>
            </table>
        </div>
    </text>
    <identifier>
        <type>
            <coding>
                <system value="http://hl7.org/fhir/v2/0203"/>
                <code value="MR"/>
            </coding>
        </type>
        <value value="37b847a5-7e5b-439e-9adf-c325f0c837c9"/>
    </identifier>
    <name>
        <use value="official"/>
        <text value="Eve Everygiard"/>
        <family value="Eve"/>
        <given value="Everywomen"/>
    </name>
    <gender value="female"/>
    <birthDate value="1980-06-10"/>
    <address>
        <use value="home"/>
        <type value="both"/>
        <text value="Gesundheitsallee 12 in 44137 Dortmund"/>
        <line value="Gesundheitsallee 12"/>
        <city value="Dortmund"/>
        <postalCode value="44137"/>
    </address>
</Patient>`;

final json & readonly testUpdateResourceDataJsonMissingId = {
    "resourceType": "Patient",
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><table class=\"hapiPropertyTable\"><tbody><tr><td>Identifier</td><td/></tr></tbody></table></div>"
    },
    "identifier": [
        {
            "type": {
                "coding": [
                    {
                        "system": "http://hl7.org/fhir/v2/0203",
                        "code": "MR"
                    }
                ]
            },
            "value": "37b847a5-7e5b-439e-9adf-c325f0c837c9"
        }
    ],
    "name": [
        {
            "use": "official",
            "text": "Eve Everygiard",
            "family": "Eve"
        }
    ],
    "gender": "female",
    "birthDate": "1980-06-10"
};

final xml & readonly testPatchResourceDataXml = xml `<Parameters xmlns="http://hl7.org/fhir">
  <parameter>
    <name value="operation"/>
    <part>
      <name value="type"/>
      <valueCode value="add"/>
    </part>
    <part>
      <name value="path"/>
      <valueString value="Patient"/>
    </part>
    <part>
      <name value="name"/>
      <valueString value="contact"/>
    </part>
  </parameter>
</Parameters>`;

ResourceLocationDetails locationDetails = {
    resourceId: "pat1",
    'version: "100"
};

final json & readonly testPatchResourceFailedData = {
    "resourceType": "OperationOutcome",
    "text": {
        "status": "generated",
        "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><h1>Operation Outcome</h1><table border=\"0\"><tr><td style=\"font-weight: bold;\">INFORMATION</td><td>[]</td><td><pre>Successfully deleted 1 resource(s) in 0ms</pre></td>\n\t\t\t</tr>\n\t\t</table>\n\t</div>"
    },
    "issue": [
        {
            "severity": "error",
            "code": "informational",
            "diagnostics": "resource doesn't exists"
        }
    ]
};

final json & readonly testHistoryDataJson = {
    "resourceType": "Bundle",
    "id": "16cf1130-d545-4aa9-9847-516d6821685f",
    "meta": {
        "lastUpdated": "2023-01-23T07:18:17.122+00:00"
    },
    "type": "history",
    "total": 6985528,
    "link": [
        {
            "relation": "self",
            "url": "http://localhost:8080/fhir_test_server/r4/_history"
        },
        {
            "relation": "next",
            "url": "http://localhost:8080/fhir_test_server/r4/_history?_count=20&_offset=20"
        }
    ],
    "entry": [
        {
            "fullUrl": "http://localhost:8080/fhir_test_server/r4/Patient/134",
            "resource": {
                "resourceType": "Patient",
                "id": "134",
                "meta": {
                    "versionId": "5",
                    "lastUpdated": "2023-01-23T07:40:48.031+00:00",
                    "source": "#iFrAshK4q3HEVFBI"
                },
                "text": {
                    "status": "generated",
                    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><div class=\"hapiHeaderText\">Caleb <b>CUSHING </b></div><table class=\"hapiPropertyTable\"><tbody><tr><td>Identifier</td><td>926df7f7-2fef-4a27-a6f2-bbf4e7da24a5</td></tr></tbody></table></div>"
                },
                "active": true,
                "name": [
                    {
                        "use": "usual",
                        "family": "Katiyar",
                        "given": [
                            "Nidhi"
                        ],
                        "suffix": [
                            "MSc"
                        ]
                    }
                ],
                "telecom": [
                    {
                        "system": "phone",
                        "value": "0648352638",
                        "use": "mobile"
                    }
                ],
                "gender": "female",
                "birthDate": "1998-01-01",
                "deceasedBoolean": false,
                "address": [
                    {
                        "use": "home",
                        "line": [
                            "Van Egmondkade 23"
                        ],
                        "city": "Amsterdam",
                        "postalCode": "1024 RJ",
                        "country": "NLD"
                    }
                ]
            },
            "request": {
                "method": "PUT",
                "url": "Patient/134/_history/5"
            },
            "response": {
                "status": "200 OK",
                "etag": "W/\"5\""
            }
        }
    ]
};

final json & readonly testHistoryDataJsonUrlRewritten = {
    "resourceType": "Bundle",
    "id": "16cf1130-d545-4aa9-9847-516d6821685f",
    "meta": {
        "lastUpdated": "2023-01-23T07:18:17.122+00:00"
    },
    "type": "history",
    "total": 6985528,
    "link": [
        {
            "relation": "self",
            "url": "http://localhost:8181/fhir/_history"
        },
        {
            "relation": "next",
            "url": "http://localhost:8181/fhir/_history?_count=20&_offset=20"
        }
    ],
    "entry": [
        {
            "fullUrl": "http://localhost:8181/fhir/Patient/134",
            "resource": {
                "resourceType": "Patient",
                "id": "134",
                "meta": {
                    "versionId": "5",
                    "lastUpdated": "2023-01-23T07:40:48.031+00:00",
                    "source": "#iFrAshK4q3HEVFBI"
                },
                "text": {
                    "status": "generated",
                    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\"><div class=\"hapiHeaderText\">Caleb <b>CUSHING </b></div><table class=\"hapiPropertyTable\"><tbody><tr><td>Identifier</td><td>926df7f7-2fef-4a27-a6f2-bbf4e7da24a5</td></tr></tbody></table></div>"
                },
                "active": true,
                "name": [
                    {
                        "use": "usual",
                        "family": "Katiyar",
                        "given": [
                            "Nidhi"
                        ],
                        "suffix": [
                            "MSc"
                        ]
                    }
                ],
                "telecom": [
                    {
                        "system": "phone",
                        "value": "0648352638",
                        "use": "mobile"
                    }
                ],
                "gender": "female",
                "birthDate": "1998-01-01",
                "deceasedBoolean": false,
                "address": [
                    {
                        "use": "home",
                        "line": [
                            "Van Egmondkade 23"
                        ],
                        "city": "Amsterdam",
                        "postalCode": "1024 RJ",
                        "country": "NLD"
                    }
                ]
            },
            "request": {
                "method": "PUT",
                "url": "Patient/134/_history/5"
            },
            "response": {
                "status": "200 OK",
                "etag": "W/\"5\""
            }
        }
    ]
};

final json & readonly testSearchDataSet1Json = {
    "resourceType": "Bundle",
    "id": "9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0",
    "meta": {
        "lastUpdated": "2022-08-01T05:21:15.483+00:00"
    },
    "type": "searchset",
    "link": [
        {
            "relation": "self",
            "url": "http://localhost:8080/fhir_test_server/r4/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=0&_count=1"
        },
        {
            "relation": "next",
            "url": "http://localhost:8080/fhir_test_server/r4/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=1&_count=1"
        }
    ],
    "entry": []
};

final json & readonly testSearchDataSet1JsonUrlRewritten = {
    "resourceType": "Bundle",
    "id": "9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0",
    "meta": {
        "lastUpdated": "2022-08-01T05:21:15.483+00:00"
    },
    "type": "searchset",
    "link": [
        {
            "relation": "self",
            "url": "http://localhost:8181/fhir/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=0&_count=1"
        },
        {
            "relation": "next",
            "url": "http://localhost:8181/fhir/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=1&_count=1"
        }
    ],
    "entry": []
};

final xml & readonly testSearchDataSet1Xml = xml `<Bundle xmlns="http://hl7.org/fhir">
    <id value="c0d4b90f-8872-4f12-9b11-56021260065f"/>
    <meta>
        <lastUpdated value="2022-08-02T04:21:45.359+00:00"/>
    </meta>
    <type value="searchset"/>
    <link>
        <relation value="self"/>
        <url value="http://localhost:8080/fhir_test_server/r4/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&amp;offset=0&amp;_count=1&amp;_format=application%2Ffhir%2Bxml"/>
    </link>
    <link>
        <relation value="next"/>
        <url value="http://localhost:8080/fhir_test_server/r4/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&amp;offset=1&amp;_count=1&amp;_format=application%2Ffhir%2Bxml"/>
    </link>
    <entry>
        <fullUrl value="http://localhost:8080/fhir_test_server/r4/Patient/2835321"/>
        <resource>
            <Patient xmlns="http://hl7.org/fhir">
                <id value="2835321"/>
            </Patient>
        </resource>
        <search>
            <mode value="match"/>
        </search>
    </entry>
</Bundle>`;

final xml & readonly testSearchDataSet1XmlUrlRewritten = xml `<Bundle xmlns="http://hl7.org/fhir">
    <id value="c0d4b90f-8872-4f12-9b11-56021260065f"/>
    <meta>
        <lastUpdated value="2022-08-02T04:21:45.359+00:00"/>
    </meta>
    <type value="searchset"/>
    <link>
        <relation value="self"/>
        <url value="http://localhost:8181/fhir/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&amp;offset=0&amp;_count=1&amp;_format=application%2Ffhir%2Bxml"/>
    </link>
    <link>
        <relation value="next"/>
        <url value="http://localhost:8181/fhir/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&amp;offset=1&amp;_count=1&amp;_format=application%2Ffhir%2Bxml"/>
    </link>
    <entry>
        <fullUrl value="http://localhost:8181/fhir/Patient/2835321"/>
        <resource>
            <Patient xmlns="http://hl7.org/fhir">
                <id value="2835321"/>
            </Patient>
        </resource>
        <search>
            <mode value="match"/>
        </search>
    </entry>
</Bundle>`;

final json & readonly testSearchDataSet2Json = {
    "resourceType": "Bundle",
    "id": "9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0",
    "meta": {
        "lastUpdated": "2022-08-01T05:21:15.483+00:00"
    },
    "type": "searchset",
    "link": [
        {
            "relation": "self",
            "url": "http://localhost:8080/fhir_test_server/r4/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=1&_count=1"
        },
        {
            "relation": "previous",
            "url": "http://localhost:8080/fhir_test_server/r4/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=0&_count=1"
        }
    ],
    "entry": []
};

final json & readonly testSearchDataSet2JsonUrlRewritten = {
    "resourceType": "Bundle",
    "id": "9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0",
    "meta": {
        "lastUpdated": "2022-08-01T05:21:15.483+00:00"
    },
    "type": "searchset",
    "link": [
        {
            "relation": "self",
            "url": "http://localhost:8181/fhir/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=1&_count=1"
        },
        {
            "relation": "previous",
            "url": "http://localhost:8181/fhir/Patient?_getpages=9b5a4db0-d6e3-45a2-b2e9-0bfc11e25fb0&offset=0&_count=1"
        }
    ],
    "entry": []
};

final json & readonly testCapStatementData = {
    "resourceType": "CapabilityStatement",
    "id": "27599c4f-8b89-4400-88db-4cfb19359346",
    "name": "RestServer",
    "status": "active",
    "date": "2022-08-01T06:07:13.610+00:00",
    "publisher": "Not provided",
    "kind": "instance"
};

final xml & readonly testCapStatementDataXml = xml `<CapabilityStatement xmlns="http://hl7.org/fhir">
	<id>27599c4f-8b89-4400-88db-4cfb19359346</id>
	<name>RestServer</name>
	<status>active</status>
	<date>2022-08-01T06:07:13.610+00:00</date>
	<publisher>Not provided</publisher>
	<kind>instance</kind>
</CapabilityStatement>`;

final json & readonly testCapStatementFullData = {
    "resourceType": "CapabilityStatement",
    "id": "27599c4f-8b89-4400-88db-4cfb19359346",
    "name": "RestServer-full",
    "status": "active",
    "date": "2022-08-01T06:07:13.610+00:00",
    "publisher": "Not provided",
    "kind": "instance"
};

final json & readonly testBatchDataJson = {
    "resourceType": "Bundle",
    "id": "bundle-request-test",
    "type": "batch",
    "entry": [
        {
            "request": {
                "method": "GET",
                "url": "/Patient/example"
            }
        },
        {
            "request": {
                "method": "GET",
                "url": "/MedicationStatement?patient=example&_list=$current-medications"
            }
        }
    ]
};

final xml & readonly testBatchDataXml = xml `<Bundle xmlns="http://hl7.org/fhir">
  <id value="bundle-request-test"/> 
  <type value="batch"/> 
  <entry> 
    <request> 
      <method value="GET"/> 
      <url value="/Condition?patient=example&amp;_list=$current-problems"/> 
    </request> 
  </entry> 
  <entry> 
    <request> 
      <method value="GET"/> 
      <url value="/MedicationStatement?patient=example&amp;notgiven:not=true"/> 
    </request> 
  </entry> 
</Bundle>`;

final json & readonly testTransactionDataJson = {
    "resourceType": "Bundle",
    "id": "bundle-transaction",
    "type": "transaction",
    "entry": [
        {
            "request": {
                "method": "GET",
                "url": "/Patient/example"
            }
        },
        {
            "request": {
                "method": "GET",
                "url": "/MedicationStatement?patient=example&_list=$current-medications"
            }
        }
    ]
};

final json & readonly testBundleDataJson = {
    "resourceType": "Bundle",
    "id": "f1c98c82-062b-452f-9f31-8fa08a31a32d",
    "type": "transaction-response",
    "link": [],
    "entry": []
};

final json & readonly testExportFileManifestData = {
    "transactionTime": "2023-03-01T11:48:06.624+00:00",
    "request": "http://localhost:8080/fhir_test_server/r4/$export",
    "requiresAccessToken": false,
    "output": [
        {
            "type": "Patient",
            "url": "http://localhost:8080/fhir_test_server/r4/Binary/123"
        }
    ],
    "error": []
};

final json & readonly testExportFileManifestDataUrlRewritten = {
    "transactionTime": "2023-03-01T11:48:06.624+00:00",
    "request": "http://localhost:8181/fhir/$export",
    "requiresAccessToken": false,
    "output": [
        {
            "type": "Patient",
            "url": "http://localhost:8181/fhir/Binary/123"
        }
    ],
    "error": []
};

final json & readonly testBulkExportCancelResponse = {
    "resourceType": "OperationOutcome",
    "issue": [
        {
            "severity": "information",
            "code": "informational",
            "diagnostics": "Job instance 2 successfully cancelled."
        }
    ]
};

final json & readonly testBulkExportCancelInvalidIDResponse = {
    "resourceType": "OperationOutcome",
    "issue": [
        {
            "severity": "error",
            "code": "processing",
            "diagnostics": "Unknown instance ID: 3. Please check if the input job ID is valid."
        }
    ]
};

final string & readonly testBulkExportFileData = string `{"resourceType":"Patient","id":"1","meta":{"versionId":"1","lastUpdated":"2023-02-07T09:40:44.219+00:00","source":"#2ZIRAfhy122O9ZqC"},"name":[{"use":"official","text":"Eve Everywomen","family":"Eve","given":["Everywomen"]}],"telecom":[{"system":"phone","value":"0712345678","use":"mobile"}],"gender":"female","birthDate":"1999-08-24"}
{"resourceType":"Patient","id":"2","meta":{"versionId":"1","lastUpdated":"2023-02-07T09:40:55.139+00:00","source":"#BvF0bfyrwRpHGc5b"},"name":[{"use":"official","text":"Eve Everygiard","family":"Eve","given":["Everygiard"]}],"telecom":[{"system":"phone","value":"0712345678","use":"mobile"}],"gender":"male","birthDate":"1999-08-24"}
`;

final json & readonly testBulkFileInvalidIDResponse = {
    "resourceType": "OperationOutcome",
    "issue": [
        {
            "severity": "error",
            "code": "processing",
            "diagnostics": "Resource Binary/3 is not known"
        }
    ]
};
