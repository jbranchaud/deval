# Extraction

This document details the process involved in extracting particular portions of
the [Voldemort](https://github.com/voldemort/voldemort) project. Because it
is such a large project (over 450 classes), it is necessary to identify an
interesting portion of the project and then prune out or stub out as much of
the rest of the project as possible.

## ConfigureNodes.java (0f8ab45)

The `ConfigureNodes.java` class is interesting because it is involved in two
different merges that resulted in build/test failures. There is a unit test
(`test/unit/voldemort/store/routed/action/ConfigureNodes.java`) that
provides the context for how to setup and work with `ConfigureNodes`. I used
this as a basis for creating the Main class (`src/voldemort/MainDecaf.java`)
that will serve as the entry point for the analysis.

We are interested in this particular file because of the merge that occurred
at c5c24d75ec20b8457e03f2fe50d7fbb9eb20b64d. This merge is the result of
some branching that occurred at 0f8ab4573bc3b9af95c8c9d33300b804814f74ad.
For that reason, we are basing this particular extraction at that branching
point (0f8ab45).

### List of Necessary Classes

Note: There is logging functionality all throughout this project which I
believe ultimately depends on `log4j.jar`. In order to reduce dependencies
that are not necessary, this logging functionality is going to be removed
from all classes listed below.

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
classes and the Action class, so it is pretty light-weight. There are also
two enums used in class (`Pipeline.Event` and `Pipeline.Operation`).

`src/voldemort/cluster/Cluster.java`

- `java.io.Serializable`
- `java.util.*`
- `voldemort.VoldemortException`
- ~~`voldemort.annotations.concurrency.Threadsafe`~~
- ~~`voldemort.annotations.jmx.JmxGetter`~~
- ~~`voldemort.annotations.jmx.JmxManaged`~~
- `voldemort.utils.Utils`
- `com.google.common.collect.Sets`

Notes: Three of the dependencies have to do with Voldemort-specific Java
annotations, perhaps these can be removed while still allowing the program
to work correctly in the context of our evaluation.
