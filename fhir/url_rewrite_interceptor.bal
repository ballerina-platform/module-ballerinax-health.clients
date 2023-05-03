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

import ballerina/regex;
import ballerina/http;

# Rewrites base url in the response payload with the given url
public isolated service class URLRewriteInterceptor {
    *http:ResponseInterceptor;
    private final string 'source;
    private final string target;

    public function init (string 'source, string target) {
        if 'source.endsWith("/") {
            self.'source = 'source.substring(0, 'source.length() - 1);
        } else {
            self.'source = 'source;
        }
        if target.endsWith("/") {
            self.target = target.substring(0, target.length() - 1);
        } else {
            self.target = target;
        }
    }

    isolated remote function interceptResponse(http:RequestContext ctx, http:Response res) returns http:NextService|error? {
        string contentType = res.getContentType();
        if contentType.includes(FHIR_XML) {
            xml payload = check res.getXmlPayload();
            string xmlString = payload.toString();
            string replaceAll = regex:replaceAll(xmlString, self.'source, self.target);
            xml afterReplace = check xml:fromString(replaceAll);
            res.setXmlPayload(afterReplace);
        } else if contentType.includes(FHIR_JSON) {
            string textPayload = check res.getTextPayload();
            string replaceAll = regex:replaceAll(textPayload, self.'source, self.target);
            json afterReplace = check replaceAll.fromJsonString();
            res.setJsonPayload(afterReplace);
        }
        return ctx.next();
    }
}
