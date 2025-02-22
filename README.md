# mcserver
Automatically deploy my Minecraft Fabric server on Ubuntu system

########### Environment Dependencies  
openjdk 21.0.6 2025-01-21 // Other versions are fine as long as they are compatible with the game version you need  
screen 4.09.00  

########### Deployment Steps  
1. Install environment dependencies  
    ```bash
    sudo apt-get install openjdk-21-jre  
    sudo apt-get install screen  
    ```

2. Run the script  
    ```bash
    chmod +x new_server.sh  
    bash new_server.sh  
    ```

3. Follow the command line prompts to enter the server name and game version.  

4. Go to the directory created by the script (server name - game version)  
    Give execution permission  
    ```bash
    chmod +x start.sh  
    bash start.sh  
    ```

########### Directory Structure Description  
```plaintext
├── Readme.md                   // help  
├── new_server.sh               // application  
├── base                        // configuration  
│   ├── version  
│   │   ├── 1.16.3              // bukkit configuration  
│   │   └── 1.18.1  
│   ├── fabric-installer-1.0.1.jar // development environment  
│   └── start.sh                // experimental  
└── natapp  
    ├── config.ini             // natapp configuration  
    └── natapp                  // natapp client  

########### V1.0.0 Version Updates

Automatic server platform setup
Allows keeping historical server versions, so the game version does not need to be re-downloaded when deploying the same version again.
