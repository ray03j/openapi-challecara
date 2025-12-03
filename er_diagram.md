```mermaid
erDiagram
    books {
        char(36) id PK "UUIDv7"
        varchar(255) title "NOT NULL"
        text description
        char(36) author_id "NOT NULL (future use)"
        varchar(500) cover_image
        varchar(100) genre
        varchar(50) status "DEFAULT 'draft'"
        datetime created_at
        datetime updated_at
        datetime deleted_at "soft delete"
    }

    Episode {
        string id PK
        string bookId FK
        string title
        string content
        number createdAt
    }

    materials {
        char(36) id PK "UUIDv7"
        char(36) book_id FK "NOT NULL"
        varchar(255) title "NOT NULL"
        varchar(50) material_type "character/world/plot/etc"
        text content
        datetime created_at
        datetime updated_at
        datetime deleted_at "soft delete"
    }

    ChatMessage {
        string id PK
        string bookId FK
        string role
        string content
        number ts
    }

    Book ||--o{ ProjectFile : has
    Book ||--o{ Episode : has
    Book ||--o{ Material : has
    Book ||--o{ ChatMessage : has

```