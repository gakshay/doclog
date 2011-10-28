module TransactionsHelper
	def add_document(form_builder)
  	link_to_function "add", :id  => "add_document" do |page|
    	form_builder.fields_for :document, Document.new, :child_index => 'NEW_RECORD' do |document_form|
    	  html = render(:partial => 'document', :locals => { :f => document_form })
    	  #page << "$('add_document').insert({ before: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
    	  page << "$('#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime())).insertBefore($('#add_document'));"
   		 end
  	end
	end
	
	def delete_document(form_builder)
    if form_builder.object.new_record?
      link_to_function("Remove this Document", "this.up('fieldset').remove()")
    else
      form_builder.hidden_field(:_delete) +
      link_to_function("Remove this Document", "this.up('fieldset').hide(); $(this).previous().value = '1'")
    end
  end
end
