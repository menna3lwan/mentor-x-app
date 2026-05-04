import json
import os
import re

def generate_postman_collection(openapi_data, output_file):
    collection = {
        "info": {
            "name": "Pro - EduCore API (Updated)",
            "description": "High-fidelity Postman collection updated from latest Swagger documentation.",
            "schema": "https://schema.getpostman.com/json/collection/v2.1.0/collection.json"
        },
        "item": []
    }

    # Initialize tag_map from global tags
    tags = openapi_data.get("tags", [])
    tag_map = {tag["name"]: [] for tag in tags}
    
    # Add a catch-all for untagged endpoints
    if "Other" not in tag_map:
        tag_map["Other"] = []

    paths = openapi_data.get("paths", {})
    schemas = openapi_data.get("components", {}).get("schemas", {})

    def resolve_schema(schema):
        if not schema:
            return None
        if "$ref" in schema:
            ref = schema["$ref"].split("/")[-1]
            return schemas.get(ref, {})
        return schema

    def generate_example_body(schema):
        schema = resolve_schema(schema)
        if not schema:
            return {}
        
        type_ = schema.get("type", "object")
        
        if type_ == "object":
            example = {}
            properties = schema.get("properties", {})
            for prop_name, prop_schema in properties.items():
                example[prop_name] = generate_example_body(prop_schema)
            return example
        elif type_ == "array":
            items = schema.get("items", {})
            return [generate_example_body(items)]
        elif type_ == "string":
            if "enum" in schema:
                return schema["enum"][0]
            if schema.get("format") == "date-time":
                return "{{$isoTimestamp}}"
            return "{{value}}"
        elif type_ == "integer" or type_ == "number":
            return 0
        elif type_ == "boolean":
            return True
        return None

    for path, path_item in paths.items():
        for method, operation in path_item.items():
            if method not in ["get", "post", "put", "delete", "patch"]:
                continue
            
            op_tags = operation.get("tags", ["Other"])
            request_name = operation.get("summary") or operation.get("operationId") or f"{method.upper()} {path}"
            
            # Build request
            request = {
                "name": request_name,
                "event": [
                    {
                        "listen": "test",
                        "script": {
                            "type": "text/javascript",
                            "exec": [
                                f"pm.test(\"{operation.get('operationId', request_name)} validation\", function () {{",
                                "    pm.expect(pm.response.code).to.be.oneOf([200, 201, 204]);",
                                "    if (pm.response.code !== 204 && pm.response.headers.get('Content-Type')?.includes('application/json')) {",
                                "        var jsonData = pm.response.json();",
                                "        pm.expect(jsonData).to.be.an('object');",
                                "    }",
                                "}});"
                            ]
                        }
                    }
                ],
                "request": {
                    "method": method.upper(),
                    "header": [
                        {
                            "key": "X-Device-Id",
                            "value": "{{X-Device-Id}}",
                            "description": "Standard device identifier for platform tracking"
                        }
                    ],
                    "url": {
                        "raw": "{{base_url}}" + path.replace("{", ":").replace("}", ""),
                        "host": ["{{base_url}}"],
                        "path": [p for p in path.split("/") if p],
                        "variable": []
                    }
                },
                "response": []
            }

            # Path variables
            path_vars = re.findall(r"\{(\w+)\}", path)
            for var in path_vars:
                request["request"]["url"]["variable"].append({
                    "key": var,
                    "value": f"{{{{{var.lower()}}}}}",
                    "description": ""
                })
                # Replace in path list for url object
                for i, segment in enumerate(request["request"]["url"]["path"]):
                    if segment == f"{{{var}}}":
                        request["request"]["url"]["path"][i] = f":{var}"

            # Query params
            parameters = operation.get("parameters", [])
            for param in parameters:
                if param["in"] == "query":
                    if "query" not in request["request"]["url"]:
                        request["request"]["url"]["query"] = []
                    request["request"]["url"]["query"].append({
                        "key": param["name"],
                        "value": f"{{{{{param['name'].lower()}}}}}",
                        "description": param.get("description", "")
                    })

            # Body
            request_body = operation.get("requestBody")
            if request_body:
                content = request_body.get("content", {})
                if "application/json" in content:
                    body_schema = content["application/json"].get("schema")
                    example = generate_example_body(body_schema)
                    request["request"]["body"] = {
                        "mode": "raw",
                        "raw": json.dumps(example, indent=4),
                        "options": {
                            "raw": {
                                "language": "json"
                            }
                        }
                    }
                elif "multipart/form-data" in content:
                    body_schema = content["multipart/form-data"].get("schema", {})
                    properties = body_schema.get("properties", {})
                    formdata = []
                    for prop_name, prop_schema in properties.items():
                        prop_type = prop_schema.get("type")
                        formdata.append({
                            "key": prop_name,
                            "type": "file" if prop_schema.get("format") == "binary" else "text",
                            "value": f"{{{{{prop_name.lower()}}}}}"
                        })
                    request["request"]["body"] = {
                        "mode": "formdata",
                        "formdata": formdata
                    }

            for tag in op_tags:
                if tag not in tag_map:
                    tag_map[tag] = []
                tag_map[tag].append(request)

    # Convert tag_map to collection items
    for tag_name, items in tag_map.items():
        if items:
            collection["item"].append({
                "name": tag_name,
                "item": items
            })

    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(collection, f, indent=4, ensure_ascii=False)

if __name__ == "__main__":
    spec_path = "/Users/kamalayman/.gemini/antigravity/brain/247101b0-a0df-45b6-8849-5ea5478b3d59/.system_generated/steps/18/content.md"
    output_path = "/Volumes/kamal-mac/Flutter-Projects/mentor-x-app/educore_api_postman_collection.json"
    
    with open(spec_path, "r", encoding="utf-8") as f:
        # Skip the source header if present
        content = f.read()
        if "---" in content:
            json_str = content.split("---", 1)[1].strip()
        else:
            json_str = content.strip()
        
        openapi_spec = json.loads(json_str)
    
    generate_postman_collection(openapi_spec, output_path)
    print(f"Postman collection generated at {output_path}")
