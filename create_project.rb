require 'gooddata'
require '/Users/marcomankerious/credentials.rb'


  client = GoodData.connect(LOGIN, PASSWORD)

blueprint = GoodData::Model::ProjectBlueprint.build("In-House Realty") do |p|
    p.add_date_dimension('followup_on')
    p.add_date_dimension('completed_on')
    p.add_date_dimension('created_on')

    p.add_dataset('dataset.followups') do |d|
      d.add_anchor('attr.followups.id')
      d.add_label('label.followups.id.name', reference: 'attr.followups.id')
    end

    p.add_dataset('dataset.facts_of_followups') do |d|
      d.add_anchor('attr.facts_of_followups.id')
      d.add_date('created_on')
      d.add_date('completed_on')
      d.add_date('followup_on')            
      d.add_fact('fact.facts_of_followups.completion_hours')

    end    

    p.add_dataset('dataset.references') do |d|
      d.add_anchor('attr.references.id')
      d.add_label('label.references.id.name', reference: 'attr.references.id')
    end   

    p.add_dataset('dataset.assignees') do |d|
      d.add_anchor('attr.assignees.id')
      d.add_label('label.assignees.id.name', reference: 'attr.assignees.id')
    end   

    p.add_dataset('dataset.creators') do |d|
      d.add_anchor('attr.creators.id')
      d.add_label('label.creators.id.name', reference: 'attr.creators.id')
    end   

    p.add_dataset('dataset.reference_types') do |d|
      d.add_anchor('attr.reference_types.type')
      d.add_label('label.reference_types.type.name', reference: 'attr.reference_types.type')
    end   

    p.add_dataset('dataset.followup_statuses') do |d|
      d.add_anchor('attr.followup_statuses.status')
      d.add_label('label.followup_statuses.status.name', reference: 'attr.followup_statuses.status')
    end   

    p.add_dataset('dataset.followup_types') do |d|
      d.add_anchor('attr.followup_types.type')
      d.add_label('label.followup_types.type.name', reference: 'attr.followup_types.type')
    end   

    p.add_dataset('dataset.action_codes') do |d|
      d.add_anchor('attr.action_codes.code')
      d.add_label('label.action_codes.code.name', reference: 'attr.action_codes.code')
    end   

    p.add_dataset('dataset.methods') do |d|
      d.add_anchor('attr.methods.method')
      d.add_label('label.methods.method.name', reference: 'attr.methods.method')
    end   

    p.add_dataset('dataset.changed_by_types') do |d|
      d.add_anchor('attr.changed_by_types.type')
      d.add_label('label.changed_by_types.type.name', reference: 'attr.changed_by_types.type')
    end   

    p.add_dataset('dataset.followup_with_types') do |d|
      d.add_anchor('attr.followup_with_types.type')
      d.add_label('label.followup_with_types.type.name', reference: 'attr.followup_with_types.type')
    end   

end

blueprint.valid? # => true

project = client.create_project_from_blueprint(blueprint, auth_token: TOKEN)

# After the project is created (might take a while) you can start using it
project.title # => "My project from blueprint"
project.datasets.count # => 2
