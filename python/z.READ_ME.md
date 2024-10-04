HELLO FELLOW DEVS!

The team has decided to move over to fast_api and python for development speed purposes. 
Since it was hard to find dev's who knew golang and every sdk every written has python support. 

All of the go code was translated to python using groq's llama3 70b model and tool calling.

The code was buggy since each file was converted one at a time, and needed a bunch of debugging.

We are also getting rid of docker containers for development. We will keep docker for deployments only -> for now. 

With our move to python we will be adopting some philosophy changes as well to better fit our current goals.

Philosophy changes:
- We want to optimize for development speed aka optimize for brain compute instead of silicon compute.
- We want to have zero environment dependencies, other than python and any db's we need, we will be using image-kit for this reason.
- We want to basically completely ignore technical debt and optimizations, unless it directly affect the end user in a noticeable way, optimization are for apps that make money, not for unfinished mvp's.
- Use third party solutions that are proven whenever possible. 
- Make dev onboarding as easy as possible.
- Have good documentation.
- Prioritize shipping features


- If you have any questions reach out on the discord, feel free to make a branch and begin implementing features right away.

- We would like a way to track features that still need to be implemented and are open to ideas, there is an eunity dashboard repo written in solidjs that could be used for this.










