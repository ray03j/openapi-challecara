import "@typespec/http";

using Http;

@service(#{
  title: "Book Management Service"
})
namespace BookService;


// -----------------------
// Models
// -----------------------
model Book {
  id: string;
  title: string;
  coverEmoji: string;
  updatedAt: int64;
  sourceCount: int32;
  archived: boolean;
  content: string;
  activeFileId: string;
}

model ProjectFile {
  id: string;
  bookId: string;
  title: string;
  content: string;
  createdAt: int64;
  updatedAt: int64;
}

model Episode {
  id: string;
  bookId: string;
  title: string;
  content: string;
  createdAt: int64;
}

model Material {
  id: string;
  bookId: string;
  title: string;
  content: string;
  createdAt: int64;
}

model ChatMessage {
  id: string;
  bookId: string;
  role: "user" | "assistant";
  content: string;
  ts: int64;
}

model Error {
  code: int32;
  message: string;
}

// -----------------------
// API Interfaces
// -----------------------
@route("/books")
interface Books {
  @get list(): Book[] | Error;
  @get read(@path id: string): Book | Error;
  @post create(@body body: Book): Book | Error;
  @patch update(@path id: string, @body body: MergePatchUpdate<Book>): Book | Error;
  @delete delete(@path id: string): void | Error;
}

@route("/project-files")
interface ProjectFiles {
  @get list(): ProjectFile[] | Error;
  @get read(@path id: string): ProjectFile | Error;
  @post create(@body body: ProjectFile): ProjectFile | Error;
  @patch update(@path id: string, @body body: MergePatchUpdate<ProjectFile>): ProjectFile | Error;
  @delete delete(@path id: string): void | Error;
}

@route("/episodes")
interface Episodes {
  @get list(): Episode[] | Error;
  @get read(@path id: string): Episode | Error;
  @post create(@body body: Episode): Episode | Error;
  @patch update(@path id: string, @body body: MergePatchUpdate<Episode>): Episode | Error;
  @delete delete(@path id: string): void | Error;
}

@route("/materials")
interface Materials {
  @get list(): Material[] | Error;
  @get read(@path id: string): Material | Error;
  @post create(@body body: Material): Material | Error;
  @patch update(@path id: string, @body body: MergePatchUpdate<Material>): Material | Error;
  @delete delete(@path id: string): void | Error;
}

@route("/chat-messages")
interface ChatMessages {
  @get list(): ChatMessage[] | Error;
  @get read(@path id: string): ChatMessage | Error;
  @post create(@body body: ChatMessage): ChatMessage | Error;
  @patch update(@path id: string, @body body: MergePatchUpdate<ChatMessage>): ChatMessage | Error;
  @delete delete(@path id: string): void | Error;
}
