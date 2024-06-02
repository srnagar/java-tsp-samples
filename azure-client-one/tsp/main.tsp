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
  title: "Single Client Sample Service",
})
@server(
  "{endpoint}/oauth",
  "Single client APIs",
  {
    /**
Supported endpoints (protocol and hostname, for example:
https://westus.client.auth.com).
 */
    endpoint: string,
  }
)
@versioned(ClientOne.Versions)
namespace ClientOne;

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

interface ClientOneSample {
    /** Gets Foo. */
    getFoo is Operations.ResourceRead<Foo>;
}

@resource("foo")
model Foo {
    @key
    fooId: string;
}