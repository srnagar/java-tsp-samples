import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Http;

// Rename a model
@@clientName(Customization.Bar, "BarModel", "java");

// Rename an operation
@@clientName(Customization.CustomizationSample.getFoo, "getFooDetails", "java");

// Rename a property in a model
@@clientName(Customization.Bar.baz, "bazName", "java");

// Renaming param in an operation has to be done directly in main.tsp (not supported through client.tsp)