#
# Description: <Method description here>
#

values_hash = {}
values_hash['!'] = '-- select from list --'

inventory_root_groups = $evm.vmdb('ManageIQ_Providers_AutomationManager_InventoryRootGroup')

inventory_root_groups.all.each do |inventory_root_group|
	$evm.log(:info, inventory_root_group.name)
	values_hash[inventory_root_group.ems_ref] = inventory_root_group.name
end

list_values = {
   'sort_by'    => :value,
   'data_type'  => :string,
   'required'   => true,
   'values'     => values_hash
}
list_values.each { |key, value| $evm.object[key] = value }

$evm.log(:info, values_hash.count)
