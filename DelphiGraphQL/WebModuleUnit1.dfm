object WebModule1: TWebModule1
  Actions = <
    item
      Default = True
      Name = 'DefaultHandler'
      PathInfo = '/'
    end>
  Height = 247
  Width = 354
  object GraphQLWebBrokerDispatcher1: TGraphQLWebBrokerDispatcher
    Options.PlaygroundEnabled = True
    Schema = GraphQLSchema1
    Left = 224
    Top = 88
  end
  object GraphQLSchema1: TGraphQLSchema
    OnInitSchema = GraphQLSchema1InitSchema
    Definition.Strings = (
      'type User {'
      '      userid: ID!'
      '      firstname : String!'
      '      lastname : String!'
      '      age: Int!'
      '}'
      ''
      'type Query {'
      '      users(id: ID): [User!]!'
      '}'
      ''
      'input UserInput{'
      '      userid: ID'
      '      firstname : String!'
      '      lastname : String!'
      '      age: Int!'
      '}'
      ''
      'type Mutation {'
      '    addUser(Input: UserInput): Int!'
      '    updateUser(Input: UserInput): Boolean!'
      '    deleteUser(id: ID): Boolean!'
      '}')
    Left = 224
    Top = 168
  end
end
