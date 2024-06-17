import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@service({
  title: "Multiple Clients Sample Service",
})
@server(
  "{endpoint}/multiclient",
  "Multiple client APIs",
  {
    /**
Supported endpoints (protocol and hostname, for example:
https://westus.client.auth.com).
 */
    endpoint: string,
  }
)
@versioned(MultipleClients.Versions)
namespace MultipleClients;

/** The Authentication service version. */
enum Versions {
  /** Version 2022-08-31 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2022-08-30`,
}

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface ClientOne {
    /** Gets Foo. */
    getFoo is Operations.ResourceRead<Foo>;
}

@resource("foo")
model Foo {
    @key
    fooId: string;
}

interface ClientTwo {
    /** Gets Bar. */
    getBar is Operations.ResourceRead<Bar>;
}


@resource("bar")
model Bar {
    @key
    barId: string;
}