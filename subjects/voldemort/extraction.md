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

Collective Dependencies:

Non-Voldemort Dependencies

- `org.junit.*`
- `java.util.*`
- `java.io.Serializable`

Voldemort.cluster Dependencies

- `voldemort.cluster.Cluster`
- `voldemort.cluster.Node`
- `voldemort.cluster.Zone`
- `voldemort.cluster.failuredetector.BannagePeriodFailureDetector`
- ~~`voldemort.cluster.failuredetector.FailureDetector`~~
- `voldemort.cluster.failuredetector.FailureDetectorConfig`
- ~~`voldemort.cluster.failuredetector.AbstractFailureDetector`~~
- ~~`voldemort.cluster.failuredetector.AsyncRecoveryFailureDetector`~~
- ~~`voldemort.cluster.failuredetector.NoopFailureDetector`~~
- ~~`voldemort.cluster.failuredetector.ThresholdFailureDetector`~~

---

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
extras are `Node` and `Zone` which I think are light-weight POJOs. This
class extends AbstractConfigureNodes which in turn extends AbstractAction.
Both of these abstract classes have been collapsed into ConfigureNodes and
then removed. There is still an extends in one of the generics for the
PipelineData, so this also needs to be abstracted at some point which should
take some work.

`src/voldemort/store/routed/Pipeline.java`

- `java.util.*`
- `voldemort.VoldemortException`
- `voldemort.store.InsufficientOperationalNodesException`
- `voldemort.store.routed.action.Action`

Notes: First, I think Pipeline.java can potentially be stubbed out.
Regardless of that, I think the only dependencies are a couple Exception
classes and the Action class, so it is pretty light-weight. There are also
two enums used in class (`Pipeline.Event` and `Pipeline.Operation`).

`src/voldemort/store/routed/BasicPipelineData.java`

Notes: The abstract class, PipelineData, has been collapsed into this class
and the other classes that use PipelineData have been modified to use
BasicPipelineData instead. The generics parameterization for this class had
to be modifed to include the ByteArray since it was no longer relying on
PipelineData.

`src/voldemort/routing/RouteToAllStrategy.java`

- ~~`voldemort.routing.RoutingStrategy`~~
- ~~`voldemort.routing.RoutingStrategyType`~~
- `voldemort.cluster.Node`

Notes: Removed the interface dependency and then deleted that interface
(`RoutingStrategy`). Also, removed the `RoutingStrategyType` class and
deleted the method that returned a particulary constant type for this class.
The other routing strategy classes had to be deleted as well
(`ConsistentRoutingStrategy` and `ZoneRoutingStrategy`).

`src/voldemort/routing/RoutingStrategyFactory.java`

- ~~`voldemort.routing.RoutingStrategy`~~
- ~~`voldemort.routing.RoutingStrategyType`~~
- ~~`voldemort.routing.ConsistentRoutingStrategy`~~
- ~~`voldemort.routing.ZoneRoutingStrategy`~~
- `voldemort.cluster.Cluster`
- `voldemort.store.StoreDefinition`

Most of the functionality for this class has been removed since it only
produces one kind of Routing Strategy now. It also has a parameter in its
only method for a `StorDefinition`, but this seems completely unneeded since
the `RoutingToAllStrategy doesn's seem to need it.

`src/voldemort/cluster/failuredetector/NodeStatus`

This class has no dependencies, so it can be left as is.

`src/voldemort/cluster/Cluster.java`

- `java.io.Serializable`
- `java.util.*`
- `voldemort.cluster.Node`
- `voldemort.cluster.Zone`
- `voldemort.VoldemortException`
- ~~`voldemort.annotations.concurrency.Threadsafe`~~
- ~~`voldemort.annotations.jmx.JmxGetter`~~
- ~~`voldemort.annotations.jmx.JmxManaged`~~
- `voldemort.utils.Utils`
- `com.google.common.collect.Sets`

Notes: Three of the dependencies have to do with Voldemort-specific Java
annotations, perhaps these can be removed while still allowing the program
to work correctly in the context of our evaluation.

`src/voldemort/cluster/Node.java`

- `java.io.Serializable`
- `java.net.*`
- `java.utils.List`
- `voldemort.utils.Utils`
- `com.google.common.collect.ImmutableList`

Notes: There were some annotations that were removed as well as Logging.

`src/voldemort/cluster/Zone.java`

- `java.io.Serializable`
- `java.util.*`

`src/voldemort/cluster/failuredetector/BannagePeriodFailureDetector.java`

- `java.utils.*`
- `org.apache.commons.lang.StringUtils`
- ~~`voldemort.annotations.jmx.JmxGetter`~~
- ~~`voldemort.annotations.jmx.JmxManaged`~~
- `voldemort.client.ClientConfig`
- `voldemort.cluster.Node`
- `voldemort.server.VoldemortConfig`
- `voldemort.store.UnreachableStoreException`

Notes: This seems like another class that will be ripe for stubbing out. It
relies on some external notifications for making a node available or not.
This can just be mocked up rather than relying on the `client.ClientConfig`
and `server.VoldemortConfig`.
This functionality from the abstract class that this class extended has been
collapsed on this class, so it no longer needs the `AbstractFailureDetector`
which means that it is no longer polymorphic. Additionally, there were some
listeners that could be subscribed to for notification which I have removed
as well in order to eliminate that additional dependency.

~~`src/voldemort/cluster/failuredetector/FailureDetector.java`~~

- `voldemort.cluster.Node`
- `voldemort.store.UnreachableStoreException`

Notes: this is an *interface*, so we need to figure out how to deal with
that. It seems like if the functionality from `AbstractFailureDetector` and
the structure of `FailureDetector` can simply be captured in the
`BannagePeriodFailureDetector` class, then we will have eliminated a few
dependencies and the polymorphism.

`src/voldemort/cluster/failuredetector/FailureDetectorConfig.java`

- `java.net.*`
- `java.util.*`
- `voldemort.client.ClientConfig`
- `voldemort.cluster.Node`
- `voldemort.server.VoldemortConfig`
- `voldemort.utils.SystemTime`
- `voldemort.utils.Time`
- `voldemort.utils.Utils`

Notes: Again, I think we are going to need to stub out the `ClientConfig`
and `VoldemortConfig` classes. It also seems like low hanging fruit to stub
out the `SystemTime` and `Time` utils since they are probably just used to
produce time values which can be spoofed.
