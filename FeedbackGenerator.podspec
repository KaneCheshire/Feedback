Pod::Spec.new do |s|
  s.name             = 'FeedbackGenerator'
  s.version          = '1.0.0'
  s.summary          = 'Feedback is a small and easy to use wrapper, for generating different styles of feedback in the form of haptics, sounds, or both.'

  s.description      = <<-DESC
  Feedback is a really easy way to provide nuanced and helpful feedback to your users on iOS.
  Feedback comes in the form of haptics, or sounds, or both. With Feedback you can use the default
  sounds for different types of feedback, or provide a custom sound to use.
                       DESC

  s.homepage         = 'https://github.com/KaneCheshire/Feedback'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kane Cheshire' => 'kane.cheshire@googlemail.com' }
  s.source           = { :git => 'https://github.com/KaneCheshire/Feedback.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/kanecheshire'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Feedback/Classes/**/*'

  s.resource_bundles = {
    'FeedbackAssets' => ['Feedback/Assets/*.m4a']
  }

  s.frameworks = 'UIKit', 'AVFoundation'
end
