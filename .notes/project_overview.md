<?xml version="1.0" encoding="UTF-8"?>
<project>
  <name>OpenHue CLI</name>
  <description>
    Command-line interface for interacting with Philips Hue smart lighting systems.
    This tool provides a convenient way to control Philips Hue lights using the command line.
  </description>
  <repository>
    <original>https://github.com/openhue/openhue-cli</original>
    <fork>git@github.com:geoffreyroeder/openhue-cli-mcp.git</fork>
  </repository>
  <features>
    <feature>Discover and connect to Philips Hue bridges</feature>
    <feature>List available lights and their status</feature>
    <feature>Control lights: on, off, brightness, and color</feature>
    <feature>Schedule light actions</feature>
  </features>
  <development>
    <environment>
      <requirement>Golang</requirement>
      <requirement>GoReleaser</requirement>
      <requirement optional="true">oapi-codegen</requirement>
      <requirement optional="true">Docker</requirement>
    </environment>
    <workflow>
      <step>Development on fork repository</step>
      <step>Testing with comprehensive coverage</step>
      <step>Pull requests to upstream when features are complete</step>
    </workflow>
  </development>
  <architecture>
    <component>CLI interface (cmd/)</component>
    <component>OpenHue API Client (openhue/)</component>
    <component>Utility functions (util/)</component>
  </architecture>
</project>