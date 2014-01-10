# 表名对应时删除mongo后缀
#module ActiveSupport::Inflector
#  def pluralize_with_mongo(word)
#    word = word[0..-7] if word[-6..-1] == '_mongo'
#    pluralize_without_mongo(word)
#  end
#  alias_method_chain :pluralize, :mongo
#end