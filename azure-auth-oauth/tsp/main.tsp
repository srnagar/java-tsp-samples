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
    OAuth2Auth<[
        {
          type: OAuth2FlowType.implicit,
          authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
          scopes: ["https://oauth.azure.net/.default"],
        }
    ]>
)
@service({
  title: "OAuth Authentication Sample Service",
})
@server(
  "{endpoint}/oauth",
  "OAuth Authentication APIs",
  {
    /** 
Supported auth endpoints (protocol and hostname, for example:
https://westus.oauth.auth.com).
 */
    endpoint: string,
  }
)
@versioned(OAuthAuthentication.Versions)
namespace OAuthAuthentication;

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

interface OAuthSample {
    // Operation Status
    /** Gets status of a Widget operation. */
    getFoo is Operations.GetResourceOperationStatus<Foo>;
}

@resource("foo")
model Foo {
    @key
    fooId: string;
}