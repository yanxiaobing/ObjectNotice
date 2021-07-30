Pod::Spec.new do |s|
    s.name         = 'ObjectNotice'
    s.version      = '1.1.0'
    s.summary      = '修复多次实例监听相同通知时通知移除问题'
    s.homepage     = 'https://github.com/yanxiaobing/ObjectNotice'
    s.license      = 'MIT'
    s.authors      = {'XBingo' => 'dove025@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/yanxiaobing/ObjectNotice.git', :tag => s.version}
    s.requires_arc = true
    s.swift_version = '4.2'
    s.source_files = 'ObjectNotice/*.swift'
end
