# Something doesn't work
Didn't find your answer here? Visit the [Discord server](https://discord.gg/2ZezMw2xvR) for support.

## Unbuilt UI
This resource uses React for the UI part which must be built before using on your server.  
You can build it yourself (if you know how) or download the [> **RELEASE** <](https://github.com/antond15/ac_scoreboard/releases/latest) from GitHub.  
If you use the green button to download it from GitHub, it won't work straight away.

## Latest version
Make sure you have the latest version of all required resources.

**Downloads**  
• [Latest version of ac_scoreboard](https://github.com/antond15/ac_scoreboard/releases/latest)  
• Latest version of your chosen framework

## Start order
ac_scoreboard must be started **AFTER** your framework.

```cfg
ensure <your_framework>
ensure ac_scoreboard
```
