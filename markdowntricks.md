# Tips and Tricks for using Markdown

There's a bunch of top tips when it comes to using markdown files.

## Keyboard tags

Did you know, you can use tags to make text look like buttons?

Use the "kbd" tag and any text you wrap in this tag will look like a button. Note, the button is NOT interactable.

**Examples**

<kbd>Boss</kbd>

Press the <kbd>ESC</kbd> key to exit out of the window.

Another great keyboard shortcut is quickly navigating to your issues by typing <kbd>g</kbd><kbd>i</kbd> on your keyboard when you are in a repository.

## Nitty Gritty details

When writing or commenting on issues/pull requests, sometimes it can be very distracting to write a whole lot of information in one go. Or you might want to log an error in your issue/PR, and this can take up a lot of space. You can use the "summary" and "details" tags to wrap your long descriptions in an expandable format.

**Examples

We found a bug in the code:

<details>
  <summary>Click to see the log report</summary>
  mod_logio:
Adds three new logging formats to the mod_log_config format specifications, including byte quantities received, sent, and transferred (combination of received and sent quantities). Normally included in the base Apache compile.
LogIOTrackTTFB: Enables time tracking between the initial request read time and the moment the first byte response is sent.

mod_filter: Provides context-sensitive filters to the output chain by registering any number of filter providers. mod_filter is not specific to logging, but allows for extracting specific requests based on the filter provider. Context containers include: main apache config, vhost config, within directory tags, and .htaccess files.

Employing this module allows for filtering requests containing such things as certain injection criteria and which IP address it’s from.

This module is provided by default in many of the package distributions, but may require enabling. For the purposes of logging, the FilterTrace directive posts information to the error log. Directives include:

AddOutputFilterByType: Assigns an output filter to a particular media type.
FilterChain: Configures a filter chain.
FilterDeclare: Declares a smart filter.
FilterProtocol: Causes the mod_filter to handle response headers correctly.
FilterProvider: Registers filter providers.
FilterTrace: Allows for debugging/diagnostic information to an error log prior to provider processing.

Example: Filtering in a vhost context container conditionally on filter and include modules:

[quote] #Declare a resource type filter: FilterDeclare xss #Register a provider: FilterProvider xss INCLUDES %{REQUEST_FILENAME}="(/[<>]+)$" #FilterProvider ... #Build the chain: FilterChain xss #Declare a custom log: CustomLog /var/www/log/xss.log xss #Format the log entry: LogFormat "%h %u %t "%r" %>s "%{Referer}i" "%{User-Agent}i"" xss [/quote]

mod_unique_id:
Constructs an environment variable and a unique identifier for each request. Often included in package distributions but may require enabling. This unique identifier is written to the access log.

This module has been superseded by mod_log_forensic for forensic purposes, but is still supported for others.

Unlike the forensic identifier, the unique identifier is passed to the application handler via the environment variable UNIQUE_ID. This allows application developers to trace a request through the web server to the application server. It can be useful for debugging a request.

Apache spins off child processes to handle requests, and a child instance processes several requests at a time. As a result, it is sometimes desirable to use a unique identifier to identify a single request across multiple server instances and child processes.

Once enabled, the module provides an identifier by default to the application handler.

Example:

[quote]UNIQUE_ID: Vaf3en8AAQEAAAtoQlAAAAAA[/quote]

The identifier is constructed from a 32-bit IP address, 32-bit process ID, 32-bit timestamp coupled to a 16-bit counter for tighter resolution than a single-second, 32-bit thread index. The timestamp component is UTC to prevent issues with daylight saving time adjustments. The application handler should treat the identifier as an opaque token only and not dissected into constituents.</details>
