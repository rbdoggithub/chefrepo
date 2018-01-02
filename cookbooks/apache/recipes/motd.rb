
hostname = node['fqdn']
file '/etc/scalyr-agent-2/agent.json' do
	content '
{
    api_key: "0lKxW849DUajlVwoqw1mnBkAJ95y_f4QyRuQRT4tt/Pc-",
    server_attributes: {
        serverHost: "'"#{hostname}"'",
        tier: "production"
}

  // Log files to upload to Scalyr.
    logs: [
        {
            path: "/usr/local/apache/logs/access_log",
            attributes: {parser: "accessLog"}
        },
        {
            path: "/usr/local/apache/logs/error_log",
            attributes: {parser: "systemLog"}
        },
        {
            path: "/usr/local/tomcat/logs/catalina.out",
            attributes: {parser: "systemLog"}
        },
        {
            path: "/usr/local/tomcat/logs/eonlineapp.log",
            attributes: {parser: "accessLog"}
        },
        {
            path: "/usr/local/tomcat/logs/localhost.*.log",
            attributes: {parser: "accessLog"}
        },
        {
            path: "/usr/local/tomcat/logs/localhost_access_log.*.txt",
            attributes: {parser: "accessLog"}
        }

    ],
    monitors: [
    ]
}
    }'

notifies :run, 'bash[scalyr_agent_reload]'


#"Hostname is this: #{hostname}" 
end





bash 'scalyr_agent_reload' do
        code <<-EOH
service scalyr-agent-2 restart
        EOH
        only_if {::File.exists?("/etc/init.d/scalyr-agent-2")}
	action :nothing
end


