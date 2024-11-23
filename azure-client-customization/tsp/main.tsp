import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using Azure.ClientGenerator.Core;

@useAuth(
    ApiKeyAuth<ApiKeyLocation.header, "api-key"> | OAuth2Auth<[
        {
          type: OAuth2FlowType.implicit,
          authorizationUrl: "https://login.microsoftonline.com/common/oauth2/authorize",
          scopes: ["https://oauth.azure.net/.default"],
        }
    ]>
)
@service({
  title: "CustomizationSamples",
})
@server(
  "{endpoint}/customize",
  "Client Customization samples",
  {
    endpoint: string,
  }
)
@versioned(Customization.Versions)
namespace Customization;

/** The Customization service version. */
enum Versions {
  /** Version 2022-08-31 */
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  `2022-08-30`,
}

interface CustomizationSample {
    @route("/foo/")
    op getFoo(@clientName("fooName", "java") foo: Foo): void;

    @route("/bar/")
    op getBar(bar: Bar): void;
}

@resource("foo")
model Foo {
    @key
    fooId: string;
}

model Bar {
   barName: string;
   baz: Baz;
}

model Baz {
   bazName: string;
}
