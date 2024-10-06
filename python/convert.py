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
def save_file(file_name: str, code: str) -> dict:
    """Saves code file, file_name must include extension"""  # Tool description
    ## save the file
    with open(f"testing/{file_name}", "w") as f:
        f.write(code)
    return {"message": "File saved."}


@ell.complex(
    model="llama3-groq-70b-8192-tool-use-preview", tools=[save_file], client=client
)
def to_file(message: str) -> str:
    return [
        ell.user(
            f"Save the following code to a file using the save_file tool, and give it a name"
            + message
        )
    ]


@ell.simple(model="llama3-70b-8192", client=client)
def convert_to(code: str, language: str):
    return f"Translate the following code to {language}: {code}"





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



## ignore this I am messing around
def convert_main_go():

    file ="testing/test.bash"
    codes = []

    with open(f"{file}", "r") as f:
        content = f.read()
        codes.append(convert_to(content, "python"))
        codes.append(convert_to(content, "javascript"))
        codes.append(convert_to(content, "java"))
        codes.append(convert_to(content, "c"))
        codes.append(convert_to(content, "c++"))
        codes.append(convert_to(content, "c#"))
        codes.append(convert_to(content, "ruby"))
        codes.append(convert_to(content, "php"))
        codes.append(convert_to(content, "swift"))
        codes.append(convert_to(content, "kotlin"))
        codes.append(convert_to(content, "typescript"))
        codes.append(convert_to(content, "rust"))
        codes.append(convert_to(content, "golang"))

        for code in codes:
            response = to_file(code)
            if response.content[0].tool_call is not None:
                print(response.content[0].tool_call())
        

        

convert_main_go()
