# Extraction

This document details the process involved in extracting particular portions of
the [Voldemort](https://github.com/voldemort/voldemort) project. Because it
is such a large project (over 450 classes), it is necessary to identify an
interesting portion of the project and then prune out or stub out as much of
the rest of the project as possible.

## ConfigureNodes.java

The `ConfigureNodes.java` class is interesting because it is involved in two
different merges that resulted in build/test failures. There is a unit test
(`test/unit/voldemort/store/routed/action/ConfigureNodes.java`) that
provides the context for how to setup and work with `ConfigureNodes`. I used
this as a basis for creating the Main class (`src/voldemort/MainDecaf.java`)
that will serve as the entry point for the analysis.

### List of Necessary Classes

`src/voldemort/MainDecaf.java`

- `org.junit.*`
- `java.util.*`
- `voldemort.cluster.Cluster`
- `voldemort.cluster.failuredetector.BannagePeriodFailureDetector`
- `voldemort.cluster.failuredetector.FailureDetector`
- `voldemort.cluster.failuredetector.FailureDetectorConfig`
- `voldemort.routing.RouteToAllStrategy`
- `voldemort.routing.RoutingStrategy`
- `voldemort.store.routed.BasicPipelineData`
- `voldemort.store.routed.Pipeline`
- `voldemort.store.routed.Pipeline.Event`
- `voldemort.store.routed.Pipeline.Operation`
- `voldemort.store.routed.action.ConfigureNodes`
- `voldemort.utils.ByteArray`
- `voldemort.xml.ClusterMapper`

`src/voldemort/store/routed/action/ConfigureNodes.java`

- `java.util.*`
- `voldemort.VoldemortException`
- `voldemort.cluster.Node`
- `voldemort.cluster.Zone`
- `voldemort.cluster.failuredetector.FailureDetector`
- `voldemort.routing.RoutingStrategy`
- `voldemort.store.routed.BasicPipelineData`
- `voldemort.store.routed.Pipeline`
- `voldemort.store.routed.Pipeline.Event`
- `voldemort.store.routed.Pipeline.Operation`
- `voldemort.utils.ByteArray`

Notes: There is a lot of overlap between the dependencies in this class and
what is needed to get things setup in MainDecaf in the first place. The only
extras are `Node` and `Zone` which I think are light-weight POJOs.

`src/voldemort/store/routed/Pipeline.java`

- `java.util.*`
- `voldemort.VoldemortException`
- `voldemort.store.InsufficientOperationalNodesException`
- `voldemort.store.routed.action.Action`

Notes: First, I think Pipeline.java can potentially be stubbed out.
Regardless of that, I think the only dependencies are a couple Exception
classes and the Action class, so it is pretty light-weight.
