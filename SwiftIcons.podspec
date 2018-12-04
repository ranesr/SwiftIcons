Pod::Spec.new do |s|
    s.name = 'SwiftIcons'
    s.version = '2.3.0'
    s.summary = 'SwiftIcons - A library for using different font icons'
    s.description = 'SwiftIcons library helps you use icons from any of these font icons - Dripicons, Emoji, FontAwesome, Icofont, Ionicons, Linearicons, Map-icons, Material icons, Open iconic, State face icons, Weather icons'

    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.authors = { 'Saurabh Rane' => 'saurabhrrane@gmail.com' }
    s.social_media_url = 'https://github.com/ranesr'
    s.homepage = 'https://github.com/ranesr/SwiftIcons'
    s.screenshots = 'https://raw.githubusercontent.com/ranesr/SwiftIcons/master/docs/images/pic01.png'

    s.source = { :git => 'https://github.com/ranesr/SwiftIcons.git', :tag => s.version }
    s.ios.deployment_target = '12.1'
    s.source_files   = 'Source/SwiftIcons.swift'
    s.resource_bundle = { 'SwiftIcons' => 'Source/Fonts/*.ttf' }

end
