
Workshop builder activity will let you define the necessary workshop configuration to build a new workshop or load an existing workshop

## Set required environment variables for the workshop 

Open set_env_vars.sh script file to set environment variables. Details on environment variables-

- **Workshop Configuration**: Sets the name and version of the new workshop.
- **Docker Registry Credentials**: Configures the Docker registry URL, username, password, and image name.
- **Code Repository Configuration**: Sets the code repository URL, commit message, username, email, access token, branch name, and a test variable.

```editor:open-file
file: ~/project/set_env_vars.sh
```

Execute the script to apply the changes:

```execute-all
source ~/project/set_env_vars.sh
```

## Create Workshop

Run the below script to create the workshop. The `create_workshop.sh` script automates workshop creation by checking environment variables and verifying if the GitHub repository exists. It clones the repository if it does; if not, it creates a new one, sets up the workshop, initializes Git, and pushes the initial content, streamlining the setup process.

```execute-1
sh ~/project/create_workshop.sh
```

## Now explore the build/cloned workshop in Editor

