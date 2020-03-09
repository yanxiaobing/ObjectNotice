Pod::Spec.new do |s|
    s.name         = 'ObjectNotice'
    s.version      = '1.0.0'
    s.summary      = '封装NotificationCenter.default，使用Closures替代#selector'
    s.homepage     = 'https://github.com/yanxiaobing/ObjectNotice'
    s.license      = 'MIT'
    s.authors      = {'XBingo' => 'dove025@qq.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/yanxiaobing/ObjectNotice.git', :tag => s.version}
    s.requires_arc = true
    s.swift_version = '4.2'
    s.source_files = 'ObjectNotice/*.swift'
end
