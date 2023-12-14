import {Elm} from "./Main.elm"
import CodeMirror from "codemirror"
import "codemirror/mode/elm/elm"
import "codemirror/lib/codemirror.css"
import "codemirror/theme/monokai.css"
import "./style.css"
import "@fontsource/fira-code"
import "codemirror/addon/hint/show-hint"

const app = Elm.Main.init({ node: document.getElementById("app") })
const el = document.getElementById("codemirror") as HTMLElement
const value = `module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


type alias Model =
    { count : Int }


initialModel : Model
initialModel =
    { count = 0 }


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { model | count = model.count + 1 }

        Decrement ->
            { model | count = model.count - 1 }


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Increment ] [ text "+1" ]
        , div [] [ text <| String.fromInt model.count ]
        , button [ onClick Decrement ] [ text "-1" ]
        ]


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
`
CodeMirror(el, {
	value: value,
	mode: "elm",
	theme: "monokai",
	lineNumbers: true,
	extraKeys: { "Ctrl-Space": "autocomplete" }, // Enable autocomplete on Ctrl-Space
	hintOptions: { hint: elmCodeCompletion }

})


// Define a simple list of Elm keywords or functions for autocompletion
const elmKeywords = [
	"module", "import", "as", "exposing",
	"type", "if", "else", "case", "of",
	"let", "in", "where"
	// Add more Elm specific keywords, functions, or types as needed
]

// Custom completion function
function elmCodeCompletion(editor) {
	const cursor = editor.getCursor() // Get the position of the cursor
	const token = editor.getTokenAt(cursor) // Get the token at the cursor position
	const start = token.start // Start position of the token
	const end = cursor.ch // Current cursor position

	// Filter the list of keywords based on the current token
	const list = elmKeywords.filter(function (item) {
		return item.startsWith(token.string)
	})

	return {
		list: list.length ? list : elmKeywords, // Show all keywords if no match
		from: CodeMirror.Pos(cursor.line, start),
		to: CodeMirror.Pos(cursor.line, end)
	}
}
