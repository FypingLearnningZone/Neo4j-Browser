# RD-Switchboard Neo4j Browser

Neo4j is the graph database that empowers RD-Switchboard platform, and the Neo4j Browser enables exploring this graph database. You can download and run the latest distribution, or build and compile the code on your development machine. Currently the tested operating system is Ubuntu 14.04 LTS.

##Download and Run the Compiled Version

* Step 1: Download neo4j.2.3.1.tar.gz
```
wget https://github.com/rd-switchboard/Neo4j-Browser/tree/master/distribution/neo4j.2.3.1.tar.gz
```

* Step 2: Uncompress the neo4j.2.3.1.tar.gz
```
 tar -zxvf neo4j.2.3.1.tar.gz
```
* Step 3: Start Neo4j Browser
```
./bin/neo4j start
```
After completing the step 3, you can access the Neo4j browser on http://localhost:7474

The default user and password is '**neo4j**/**neo4j**'

* Close Neo4j process
```
./bin/neo4j stop
```
 


##Compiling the code

If you need to change and compile the code, the instruction for building the Neo4j Browser code is available at
https://github.com/rd-switchboard/Neo4j-Browser/blob/master/code/README.asciidoc
