# NOTE:
 You must export AWS_PROFILE="default"
          export AWS_REGION="us-east-1"
# S3:
 Make sure the exact bucket name (bucket = 'name' in state.tf) exists before running this terraform.
 
 YOU MUST COMMENT OUT THE BACKEND SECTION (between the backend {} curleys in the provider.tf) file AND RUN IT ONCE FIRST TO CREATE THE terraform.state FILE AND DYNAMODB TABLE
 
 Then come back, uncomment the backend section (between the curleys {} in the provider.tf file)
 
 Go back to CLI, and perform 
 ```
 terraform init -reconfigure
 terraform apply -auto-approve
 ``` 
 Answer 'yes' to migrate the state to S3
 
 Answer 'yes' to migrate the state to S3
 
 Your tfstate is now located on S3

# Repo create commands:
create repo in the web UI
```
git init
git add .
git commit -m "first commit"
git branch -M main
tree terraform
git status
git remote add origin https://github.com/surfd4wg/remoteTFstate.git
git push -u origin main
```
## License
[MIT](https://choosealicense.com/licenses/mit/)
