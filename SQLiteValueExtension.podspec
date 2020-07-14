
Pod::Spec.new do |s|
  s.name         = "SQLiteValueExtension"
  s.version = "0.0.2"
  s.summary      = "SQLiteValueExtension"
  s.homepage     = "https://github.com/pujiaxin33/SQLiteValueExtension"
  s.license      = "MIT"
  s.author       = { "pujiaxin33" => "317437084@qq.com" }
  s.platform     = :ios, "9.0"
  s.swift_version = "5.0"
  s.source       = { :git => "https://github.com/pujiaxin33/SQLiteValueExtension.git", :tag => "#{s.version}" }
  s.framework    = "UIKit"
  s.source_files  = "Sources", "Sources/*.{swift}"
  s.requires_arc = true
  
  s.dependency 'SQLite.swift'
end
