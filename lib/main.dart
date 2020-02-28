import 'package:flutter/material.dart';
import 'package:woodemi_service/ConfigService.dart';
import 'package:woodemi_service/WoodemiService.dart';
import 'package:woodemi_service/model.dart';

import 'ConfigManager.dart';
import 'widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initConfig();
  }

  void initConfig() async {
    WoodemiService.clientAgent = await configManager.getClientAgent();
    configService.environment = await configManager.getEnvironment();
    await configService.fetchConfig();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MagicTool',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WoodemiService.clientAgent == null ||
              configService.environment == null
          ? _configSelection()
          : _buildHome(),
    );
  }

  final clientAgents = [
    ClientAgent.aSmartnoteLight,
    ClientAgent.iSmartnoteLight,
    ClientAgent.aSmartnote,
    ClientAgent.iSmartnote,
    ClientAgent.aUgeenote,
    ClientAgent.iUgeenote,
  ];

  final environments = [
    Environment.sSmartnote,
    Environment.pSmartnote,
    Environment.pUgeenote,
  ];

  ClientAgent _clientAgent;
  Environment _environment;

  Widget _configSelection() {
    return centerCard(
      content: centerContainer(
        height: 300,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('ClientAgent'),
                Container(
                  width: 20,
                ),
                DropdownButton(
                  items: clientAgents
                      .map((clientAgent) => DropdownMenuItem(
                            value: clientAgent,
                            child: Text(clientAgent.title),
                          ))
                      .toList(),
                  value: _clientAgent,
                  onChanged: (value) => setState(() => _clientAgent = value),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Environment'),
                Container(
                  width: 20,
                ),
                DropdownButton(
                  items: environments
                      .map((environment) => DropdownMenuItem(
                            value: environment,
                            child: Text(environment.title),
                          ))
                      .toList(),
                  value: _environment,
                  onChanged: (value) => setState(() => _environment = value),
                ),
              ],
            ),
            RaisedButton(
              child: Text('ok'),
              onPressed: () async {
                WoodemiService.clientAgent = _clientAgent;
                configService.environment = _environment;
                await configManager.setClientAgent(_clientAgent);
                await configManager.setEnvironment(_environment);
                await configService.fetchConfig();
                setState(() {});
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHome() {
    return Center(
      child: Text('Home'),
    );
  }
}