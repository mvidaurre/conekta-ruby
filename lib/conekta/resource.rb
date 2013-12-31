module Conekta
  class Resource < ConektaObject
    def self.class_name
      self.name.split('::')[-1]
    end
    def self.url()
      if self.class == "Resource"
        raise Exception.new("Resource is an abstract class")
      end
      "/#{CGI.escape(self.class_name.downcase)}s"
    end
    def url
      if id == nil
        raise Exception.new("no id")
      end
      self.class.url + "/" + id
    end
    def self.get(id)
      instance = self.new(id)
      url = instance.url
      requestor = Requestor.new
      response = requestor.request(:get, url)
      instance.load_from(response)
      instance
    end
  end
end