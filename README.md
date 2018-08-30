# UITableView with Left-Aligned Section Headers

`UITableViewController` subclass implementation that demonstrates how to 
leverage the table view delegate and data source methods to simulate flowating 
section headers with an alternative layout.


### Background

The built-in section header functionality for non-grouped tables places the 
section header views vertically, between the last row of a section and the first 
row of the next.

This implementation, in contrast, removes all vertical space between succcessive 
sections and instead positions each section header floating at the top left of 
the first row in the section.

At first thought, this layout could be realized by specifying a section header
height of less than 1, and passing a custom header view to 
`tableView(_:viewforHaderInSection:)` that has `clipsToBounds` set to `false`, 
and from which a subview with the desired header size and layout "hangs". 

However, as far as the table view knows, the real section header is still less 
that 1 point in height and the "push the previous header off-screen" behaviour breaks: 
successive section headers' child views will overlap instead of pushing each 
other vertically.

Instead, we specify nil for the header views and/or zero height, and add custom
subviews to the table at the appropriate positions and with the appropriate 
autolayout constraints so as to achieve the desried behaviour. 
