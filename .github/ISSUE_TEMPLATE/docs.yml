name: "📝 Documentation"
description: "문서 작업을 위한 템플릿입니다. Template for documentation work"
title: "[Docs] "
labels: ["Docs"]
body:
  - type: dropdown
    id: category
    attributes:
      label: "🎯 문서 분류 Category"
      options:
        - README (리드미 작성/수정)
        - Guide (가이드/튜토리얼 문서)
        - API (API 문서/프로토콜 명세)
        - Wiki (위키 문서 작성/수정)
        - Else (기타)
    validations:
      required: true

  - type: textarea
    id: content
    attributes:
      label: "📝 문서 내용 Document Content"
      placeholder: |
        예시 Ex:
        - 문서화할 내용: 로그인 모듈의 사용법과 예제
          Content to document: Usage and examples of the login module.
      description: "문서화할 내용을 구체적으로 작성해주세요.\nPlease provide the specific content to be documented."
    validations:
      required: true

  - type: textarea
    id: additional
    attributes:
      label: "ℹ️ 추가 정보 Additional information"
      placeholder: |
        예시 Ex:
        - 관련 이슈: #42, #123 Related issues: #42, #123
        - 참고 문서 Reference Documents
        - 기타 고려사항 Other Considerations
      description: "문서 작업 시 참고할 만한 추가 정보(관련 이슈, 문서 등)가 있다면 작성해주세요.\nPlease provide any additional information that may help with the documentation (related issues, reference docs, etc)."
