#!/bin/bash

# set the vars below to match your environment

profile="default"
region="us-east-1"
endpointName=""

# loop through each headline
while read headline; do
        i=$((i+1))
        # create temporary file to store headline as JSON
        touch ./input.json

        # Write headline as JSON to loopfile
        echo "{ \"input\": \"$headline\" }" > ./input.json

        # Display output
        echo "---"
        echo "Headline [$i]: $headline"
        echo "Classification: $($(which aws) --profile "$profile" --region "$region" sagemaker-runtime invoke-endpoint --endpoint-name "$endpointName" --body fileb://input.json --content-type=application/json >(cat) 1>/dev/null)"

        # Remove loopfile for next item
        rm ./input.json

done <headlines.txt
