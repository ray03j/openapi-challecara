import "@typespec/http";

using Http;

@service(#{
  title: "Book Management Service"
})
@doc("本の作成・更新・削除・取得を行うAPI")
namespace BookService;


// -----------------------
// Models
// -----------------------
@doc("本の情報を管理するモデル")
model Book {
  @doc("本の一意のID")
  id: string;

  @doc("本のタイトル")
  title: string;

  @doc("本の表紙絵文字")
  coverEmoji: string;

  @doc("最終更新日時（UNIXタイムスタンプ）")
  updatedAt: int64;

  @doc("本に紐づくソース数")
  sourceCount: int32;

  @doc("アーカイブ済みかどうか")
  archived: boolean;

  @doc("本の内容")
  content: string;
}

@doc("本に紐づくプロジェクトファイルの情報を表すモデル")
model ProjectFile {
  @doc("プロジェクトファイルの一意のID")
  id: string;

  @doc("このファイルが属する本のID")
  bookId: string;

  @doc("ファイルのタイトル")
  title: string;

  @doc("ファイルの内容")
  content: string;

  @doc("作成日時（UNIXタイムスタンプ）")
  createdAt: int64;

  @doc("最終更新日時（UNIXタイムスタンプ）")
  updatedAt: int64;
}

@doc("本に紐づくエピソードの情報を表すモデル")
model Episode {
  @doc("エピソードの一意のID")
  id: string;

  @doc("このエピソードが属する本のID")
  bookId: string;

  @doc("エピソードのタイトル")
  title: string;

  @doc("エピソードの内容")
  content: string;

  @doc("作成日時（UNIXタイムスタンプ）")
  createdAt: int64;
}

@doc("本に紐づく参考資料の情報を表すモデル")
model Material {
  @doc("資料の一意のID")
  id: string;

  @doc("この資料が属する本のID")
  bookId: string;

  @doc("資料のタイトル")
  title: string;

  @doc("資料の内容")
  content: string;

  @doc("作成日時（UNIXタイムスタンプ）")
  createdAt: int64;
}

@doc("本に紐づくチャットメッセージの情報を表すモデル")
model ChatMessage {
  @doc("チャットメッセージの一意のID")
  id: string;

  @doc("このメッセージが属する本のID")
  bookId: string;

  @doc("メッセージの送信者。ユーザーかアシスタントか")
  role: "user" | "assistant";

  @doc("メッセージの内容")
  content: string;

  @doc("メッセージの送信日時（UNIXタイムスタンプ）")
  ts: int64;
}

@doc("エラー情報を表すモデル")
model Error {
  @doc("エラーコード")
  code: int32;

  @doc("エラーメッセージ")
  message: string;
}

// -----------------------
// API Interfaces
// -----------------------
@route("/books")
@doc("本の一覧取得、作成、更新、削除を行うエンドポイント群")
interface Books {
  
  @get
  @doc("すべての本の一覧を取得します")
  list(): Book[] | Error;

  @get
  @doc("指定したIDの本の詳細情報を取得します")
  read(
    @path 
    @doc("取得する本のID")
    id: string
  ): Book | Error;

  @post
  @doc("新しい本を作成します")
  create(
    @body
    @doc("作成する本の情報")
    body: Book
  ): Book | Error;

  @patch
  @doc("指定したIDの本情報を部分更新します")
  update(
    @path
    @doc("更新する本のID")
    id: string,
    @body
    @doc("更新する本の情報（部分更新）")
    body: MergePatchUpdate<Book>
  ): Book | Error;

  @delete
  @doc("指定したIDの本を削除します")
  delete(
    @path
    @doc("削除する本のID")
    id: string
  ): void | Error;
}

@route("/episodes")
@doc("本に紐づくエピソードの一覧取得、作成、更新、削除を行うエンドポイント群")
interface Episodes {
  
  @get
  @doc("すべてのエピソードの一覧を取得します")
  list(): Episode[] | Error;

  @get
  @doc("指定したIDのエピソード詳細を取得します")
  read(
    @path
    @doc("取得するエピソードのID")
    id: string
  ): Episode | Error;

  @post
  @doc("新しいエピソードを作成します")
  create(
    @body
    @doc("作成するエピソードの情報")
    body: Episode
  ): Episode | Error;

  @patch
  @doc("指定したIDのエピソード情報を部分更新します")
  update(
    @path
    @doc("更新するエピソードのID")
    id: string,
    @body
    @doc("更新するエピソード情報（部分更新）")
    body: MergePatchUpdate<Episode>
  ): Episode | Error;

  @delete
  @doc("指定したIDのエピソードを削除します")
  delete(
    @path
    @doc("削除するエピソードのID")
    id: string
  ): void | Error;
}

@route("/materials")
@doc("本に紐づく参考資料の一覧取得、作成、更新、削除を行うエンドポイント群")
interface Materials {

  @get
  @doc("すべての参考資料の一覧を取得します")
  list(): Material[] | Error;

  @get
  @doc("指定したIDの資料詳細を取得します")
  read(
    @path
    @doc("取得する資料のID")
    id: string
  ): Material | Error;

  @post
  @doc("新しい資料を作成します")
  create(
    @body
    @doc("作成する資料の情報")
    body: Material
  ): Material | Error;

  @patch
  @doc("指定したIDの資料情報を部分更新します")
  update(
    @path
    @doc("更新する資料のID")
    id: string,
    @body
    @doc("更新する資料情報（部分更新）")
    body: MergePatchUpdate<Material>
  ): Material | Error;

  @delete
  @doc("指定したIDの資料を削除します")
  delete(
    @path
    @doc("削除する資料のID")
    id: string
  ): void | Error;
}


@route("/chat-messages")
@doc("本に紐づくチャットメッセージの一覧取得、作成、更新、削除を行うエンドポイント群")
interface ChatMessages {

  @get
  @doc("すべてのチャットメッセージの一覧を取得します")
  list(): ChatMessage[] | Error;

  @get
  @doc("指定したIDのチャットメッセージ詳細を取得します")
  read(
    @path
    @doc("取得するメッセージのID")
    id: string
  ): ChatMessage | Error;

  @post
  @doc("新しいチャットメッセージを作成します")
  create(
    @body
    @doc("作成するチャットメッセージの情報")
    body: ChatMessage
  ): ChatMessage | Error;

  @patch
  @doc("指定したIDのチャットメッセージ情報を部分更新します")
  update(
    @path
    @doc("更新するメッセージのID")
    id: string,
    @body
    @doc("更新するチャットメッセージ情報（部分更新）")
    body: MergePatchUpdate<ChatMessage>
  ): ChatMessage | Error;

  @delete
  @doc("指定したIDのチャットメッセージを削除します")
  delete(
    @path
    @doc("削除するメッセージのID")
    id: string
  ): void | Error;
}
