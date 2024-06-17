import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;


@service({
  title: "Contoso Widget Manager",
})
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
namespace Contoso.WidgetManager;

alias ServiceTraits = SupportsRepeatableRequests &
  SupportsConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

/** A widget. */
@resource("widgets")
model Widget {
  @key("widgetName")
  /** The widget name. */
  @visibility("read")
  name: string;

  /** The ID of the widget's manufacturer. */
  manufacturerId: string;
}

interface Widgets {
  /** Fetch a Widget by name. */
  getWidget is Operations.ResourceRead<Widget>;

  /** Creates or updates a Widget. */
  createOrUpdateWidget is Operations.ResourceCreateOrUpdate<Widget>;

  /** Delete a Widget. */
  deleteWidget is Operations.ResourceDelete<Widget>;

  /** List Widget resources. */
  listWidgets is Operations.ResourceList<Widget>;
}