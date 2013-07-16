Rails.application.config.middleware.use OmniAuth::Builder do
    provider :weibo,'324854913','841f2fcec743e8b5eb394a120c2f923d'
    provider :facebook, '448899731786780' ,'e02b6dd8c83e3c2a9559c77817905ed5', scope: 'email,publish_stream'
    provider :instagram, '4450080f39ce4657981253a4a9380486','c53d326d0d304529b89b8ea953a291a1'
end
