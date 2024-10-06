Please create a virtual python enviroment using 

``` python -m venv venv ```

Then activate the virtual enviroment this will vary depending on your operating system.
Google is your friend.

Microsoft Windows:

```. venv\Scripts\activate ```


Then install the requirements using 

``` pip install -r requirements.txt ```

Then run the server using 

``` python main.py ```


For live reloading use


``` uvicorn main:app --reload ```


If you install any new python packages please add them to the requirements.txt file using 

``` pip freeze > requirements.txt ```