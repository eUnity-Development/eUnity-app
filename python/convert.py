import openai
from dotenv import load_dotenv
import os
import ell
import json

load_dotenv()

directory = "/home/gabriel/Desktop/eunityco/eunity/backend"

sub_dir = "routes"

client = openai.Client(
    api_key=os.getenv("GROQ_API_KEY"), base_url="https://api.groq.com/openai/v1"
)


@ell.tool(model="llama3-groq-70b-8192-tool-use-preview", client=client)
def save_python(path: str, code: str) -> dict:
    """Saves python file."""  # Tool description
    ## save the file
    with open(f"testing/{path}", "w") as f:
        f.write(code)
    return {"message": "File saved."}


@ell.complex(
    model="llama3-groq-70b-8192-tool-use-preview", tools=[save_python], client=client
)
def to_file(message: str, save_name: str) -> str:
    return [
        ell.user(
            f"Save the following code to a file using the save_python tool, and path {save_name}"
            + message
        )
    ]


@ell.simple(model="llama3-70b-8192", client=client)
def convert_to_python(message: str):
    return f"Translate the following go code to python's fast api: {message}"


# @ell.simple(model="llama3-70b-8192", client=client)
# def convert_to_go(prompt: str):
#     """You are a go web app converter use fast_api in python"""
#     return f"Convert the following go code to python if it's a web app use fast_api: {prompt}"


### list all files in their relative paths to backend folder
def list_files():
    import os

    for root, dirs, files in os.walk(directory):
        for f in files:
            print(f"{root}/{f}")


# list_files()

##grab the files under routes folder and convert them to python


def getAllFilesFromSubDir(sub_dir):
    import os

    names = []

    print(sub_dir)
    for root, dirs, files in os.walk(sub_dir):
        for f in files:
            print(len(files))
            print(f"{root}/{f}")
            ## get rid of the .go extension and the absolute path

            name = f.split(".")[0]
            names.append(f"{root}/{name}")
    return names


def convert_main_go():

    files = getAllFilesFromSubDir(f"{directory}/{sub_dir}")

    print(files)

    for file in files:
        with open(f"{file}.go", "r") as f:
            content = f.read()
            ## save name just change extension to .py also get rif of the absolute path
            save_name = file.split("/")[-1].replace(".go", ".py")
            print("Save name: ", save_name)
            converted_code = convert_to_python(content)
            response = to_file(converted_code, save_name)
            ## save response to file as json
            if response.content[0].tool_call is not None:
                print(response.__dict__)
               

                ## I can just call directly
                print(response.content[0].tool_call())

                # print(response.content[0].tool_call.params)
                # ## check if params is object, dict or list or string
                # print(type(response.content[0].tool_call.params))
                # save_python(
                #     response.content[0].tool_call.params.path,
                #     response.content[0].tool_call.params.code,
                # )


convert_main_go()
