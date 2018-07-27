import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
main : Program Never Model Msg
main = Html.beginnerProgram{view=view, model=model, update=update}

--model

type alias Model =
    { todo : String
    , todos : List String
    }
model : Model
model = 
    { todo = ""
    , todos = []
    }
--update
stylesheet : Html msg
stylesheet = 
    let tag = "link"
        attrs =
            [ attribute "Rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
            ]
        children =
                []
    in
        node tag attrs children


type Msg
    = UpdateTodo String
    | AddTodo
    | RemoveAll
    | RemoveItem String
    | ClearInput

update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateTodo text -> { model | todo = text }
        AddTodo -> { model | todos = model.todo :: model.todos }
        RemoveAll -> {model | todos = []}
        RemoveItem text -> {model | todos = List.filter(\x -> x /= text) model.todos}
        ClearInput -> { model | todo = ""}

--view
todoItem : String -> Html Msg
todoItem todo = li [][text todo, button [onClick (RemoveItem todo)] [text "X"]]

todoList : List String -> Html Msg
todoList todos =
    let child = List.map todoItem todos
    in
        ul [] child
view : { a | todo : String, todos : List String } -> Html Msg
view model =
    div [class "jumbotron"]
        [stylesheet
        , input [type_ "text"
        , onInput UpdateTodo
        , value model.todo
        , onMouseEnter ClearInput
        , class "form-control"]
        []
        , button [ onClick AddTodo, class "btn btn-primary"][text "submit"]
        , button [ onClick RemoveAll, class "btn btn-danger"][text "Remove all"]
        , div [] [ todoList model.todos]
        ]