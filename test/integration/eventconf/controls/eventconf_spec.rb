# frozen_string_literal: true
control 'eventconf' do
  describe eventconf('bogus-events.xml') do
    it { should exist }
    # 20+ is position 2
    its('position') { should be <= 3 }
    content = <<-EOL
<events xmlns="http://xmlns.opennms.org/xsd/eventconf">
  <event>
    <uei>uei.opennms.org/bogus/alert</uei>
    <event-label>OpenNMS defined event: A bogus event has been received</event-label>
    <descr>
      This event is generated by solar flares
    </descr>
    <logmsg dest='logndisplay'>
      &lt;p&gt;Bogus Alert!&lt;/p&gt;
    </logmsg>
    <severity>Warning</severity>
  </event>
</events>
EOL
    its('content') { should eq content }
  end
end