#
# Description: <Method description here>
#

$evm.root.attributes.sort.each { |k, v| $evm.log(:info, "\t Attribute: #{k} = #{v}")}

values_hash = {}
values_hash['!'] = '-- select from list --'

inventory_root_group_ems_ref = $evm.root['dialog_inventory_root_group']

# inventory_root_group_ems_ref = 2

$evm.log(:info, inventory_root_group_ems_ref)

inventory_root_group = $evm.vmdb('ManageIQ_Providers_AutomationManager_InventoryRootGroup').find_by(:ems_ref => inventory_root_group_ems_ref.to_i)

$evm.log(:info, inventory_root_group.inspect)

inventory_root_group_id = inventory_root_group.id

configured_systems = $evm.vmdb(:ExtManagementSystem).find_by(:type=>"ManageIQ::Providers::AnsibleTower::AutomationManager").configured_systems

# $evm.log(:info, configured_systems.inspect)

$evm.log(:info, configured_systems.count)

configured_systems.each do |configured_system|
  if configured_system.inventory_root_group_id == inventory_root_group_id
    $evm.log(:info, configured_system.hostname)
    values_hash[configured_system.hostname] = configured_system.hostname
  end
end

list_values = {
   'sort_by'    => :value,
   'data_type'  => :string,
   'required'   => true,
   'values'     => values_hash
}
list_values.each { |key, value| $evm.object[key] = value }

$evm.log(:info, values_hash.count)
