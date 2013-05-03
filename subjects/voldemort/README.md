# Voldemort

The [Voldemort project](https://github.com/voldemort/voldemort) is large
Java project with a rich, complex commit history full of extensive parallel
development activity.

## Conflicting Merges

The following are a few merges that were found to result in build failures
or test failures. A more extensive list of these merges can be found in
[MergeConflicts.txt]().

- c5c24d75ec20b8457e03f2fe50d7fbb9eb20b64d
  - against 02342be701e9bec1ab38be71107c21fd2107350c
    - src/java/voldemort/store/routed/action/ConfigureNodes.java
  - against 6c1d6ccf2ae983e2788ee388da5cf9dbb10fddf3
    - src/java/voldemort/store/routed/action/ConfigureNodes.java

- d92108cdd255991b17dfd858ee220ecf8eaab556
  - against 0f8ab4573bc3b9af95c8c9d33300b804814f74ad
    - src/java/voldemort/store/routed/action/ConfigureNodes.java
  - against 91da56d44a1c792841143dcfe5793a519a7124d6
    - src/java/voldemort/store/routed/action/ConfigureNodes.java

- 39898c14da6b6f6385849800c7c5df09855036d8
  - against 8b0a7c292dce025a4469c5ae22613f187ba863ae
    - build.properties
    - build.xml
  - against 20dfa29fd377b3a759a1506bd5af5f2ac6014456
    - src/java/voldemort/store/routed/action/PerformSerialRequests.java

- 66f5a79

- f299001

- 475b823172ca907cced8e851a9bb50c4faf0c5a5
  - against bac0fa7c83df7dd9ade998e7736ceee431c1caca
    - src/java/voldemort/store/readonly/ReadOnlyStorageEngine.java
  - against 4bc49d896a46d38fb28b63ea9e1b072fbc49bc59
    - src/java/voldemort/utils/KeyDistributionGenerator.java
    - src/java/voldemort/utils/RebalanceUtils.java

- fbae492

- b9d885faa6516c61e217928b62984a7d115d4add
  - against ba1512e8f7cbd46b308291c0787d07ea982cfd76
    - src/java/voldemort/store/readonly/ReadOnlyStorageEngine.java
    - src/java/voldemort/store/routed/action/PerformParallelDeleteRequests.java
    - ...
  - against 983dbd031b100b8a9bf5ccbff1901a666da34026
    - src/java/voldemort/client/rebalance/MigratePartitions.java
    - test/unit/voldemort/client/rebalance/MigratePartitionsTest.java

