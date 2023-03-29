Terraform project 3: This will involve AWS Lambda, Amazon API Gateway, Amazon DynamoDB, Amazon Cognito, and AWS Amplify. Basically focusing on serverless technologies here. Do all these manually first and then write terraform for this using modules ofcourse 

  

Architecture diagram 

  ![MicrosoftTeams-image (1)](https://user-images.githubusercontent.com/123386504/228483418-fe2de571-76bb-464c-a638-393517d3a078.png)


Steps: 

Static Web Hosting with Continuous Deployment:  

Create a repo in CodeCommit with <first>-<lastname>-wildrydes and populate the repo with content from following bucket. Download the content from the bucket using this command "aws s3 cp s3://wildrydes-us-east-1/WebApplication/1_StaticWebHosting/website ./ --recursive" 

Create a New App in Amplify and integrate it with CodeCommit. On the Configure build settings page, leave all the defaults, Select Allow AWS Amplify to automatically deploy all files hosted in your project root directory 

Once completed, click on the site image to launch your Wild Rydes site. 

Provide DNS to the URL. <first>-<lastname>-wildrydes.dns-poc-onprem.tk 

User Management  

Create AWS Cognito User Pool and Integrate with our App: Create user pool is the Cognito service. Select User name and choose No MFA, select defaults for other options. Note the Pool ID and the App client ID on the Pool details page of the newly created user pool. 

Update /js/config.js: Add userPoolId, userPoolClientId and region; push the code. 

Serverless Service Backend  

Create DynamoDB Table: Name the table as FirstnameLastameRides. Enter RideId for the Partition key and select String for the key type 

IAM Role for Lambda: Create Role for Lambda, provide "AWSLambdaBasicExecutionRole". Name role as FirstnameLastame-WildRydesLambda-role. 
 Create Inline Policy for the role, Choose DynamoDB and under actions select PutItem. Under Resources, paste the ARN of the table. Give "DynamoDBWriteAccess" name to the inline policy 

Lambda function: Name it FirstnameLastameRequestUnicorn. Select Node.js 16.x for the Runtime. Select the role which we earlier created. 
 Copy the content for lambda from here: https://webapp.serverlessworkshops.io/serverlessbackend/lambda/requestUnicorn.js. Replace "Rides" to "FirstnameLastameRides" (this table was created earlier, so give the exact name). Choose Deploy 

Deploy a RESTful API  

API Gateway > Select Build under REST API > Name: FirstnameLastameWildRydes > Edge optimized in the Endpoint Type dropdown > Create API 

Create a new resource called /ride within your API. Enable API Gateway CORS for the resource > Create Resource 
 From the Action dropdown select Create Method, select POST and then click the checkmark. 
 Select Lambda Function for the integration type > Lambda Proxy integration > Enter the name of the function earlier created 
 Under Method Request, edit Authorization to use Cognito Pool 
 Finally Deploy the API 

Update the /js/config.js file: Update the invokeUrl setting. Set the value to the Invoke URL for the deployment stage earlier created 

  

You can refer this doc for step by step guide: https://aws.amazon.com/getting-started/hands-on/build-serverless-web-app-lambda-apigateway-s3-dynamodb-cognito/?refid=a0465925-8003-4d68-bc59-c7cd4211829e 

 

 
