import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(
  ApiKeyAuth<ApiKeyLocation.header, "api-key">
)
@service({
  title: "API Key Authentication Sample Service",
})
@server(
  "{endpoint}/apiauth",
  "API Key Authentication APIs",
  {
    /** 
Supported auth endpoints (protocol and hostname, for example:
https://westus.api.auth.com).
 */
    endpoint: string,
  }
)
@versioned(ApiKeyAuthentication.Versions)
namespace ApiKeyAuthentication;

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

interface ApiKeyAuthSample {
    // Operation Status
    /** Gets status of a Widget operation. */
    getFoo is Operations.GetResourceOperationStatus<Foo>;
}

@resource("foo")
model Foo {
    @key
    fooId: string;
}