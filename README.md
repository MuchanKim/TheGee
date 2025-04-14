# .github-template
> A GitHub template designed to streamline collaboration through standardized issue/PR templates and repository settings.  
> Issue and PR templates are included, while branch strategies and labels are recommended to be customized for your needs.  
> Feel free to modify and use it to enhance your project's collaboration workflow.
>
> 표준화된 이슈/PR 템플릿과 저장소 설정을 통해 협업을 더 효율적으로 하기 위한 GitHub 템플릿입니다.  
> 이슈 템플릿과 PR 템플릿이 포함되어 있고, 브랜치나 라벨은 별도로 설정하시는 걸 권유드립니다.  
> 프로젝트의 협업 워크플로우 개선을 위해 자유롭게 수정하고 사용하실 수 있습니다.
>
> _by Moo_

[![Last Updated](https://img.shields.io/badge/last%20updated-2025--03--03-brightgreen)](https://github.com/username/github-template/commits/main)

## 📌 Main Features | 주요 기능

### 1. Issue Templates | 이슈 템플릿
- 😵 Bug Report | 버그 리포트 (`bug_report.yml`)
- ✨ Feature Request | 기능 요청 (`feature_request.yml`)
- ♻️ Refactoring | 리팩토링 (`refactor.yml`)
- 📝 Documentation | 문서 작업 (`docs.yml`)
- 🔧 Chore | 잡일 (`chore.yml`)
- 💭 Topic | 토픽 (`topic.yml`)

### 2. PR Templates | PR 템플릿
- 🔄 PR type
- 📝 Description | 설명
- 🔍 Related Issues | 관련 이슈
- 📸 Screenshot | 스크린샷
- ✅ Checklist | 체크리스트
- 📋 Review requirements and additional information | 리뷰 요구사항 및 추가 설명

### 3. Branch Strategy | 브랜치 전략

#### Branch Description | 브랜치 설명
| Branch | Description | 설명 |
|--------|-------------|------|
| `main` | Product release/deployment branch | 제품 출시/배포용 브랜치 |
| `hotfix/*` | Emergency fix branch for released version | 출시 버전의 긴급 수정 브랜치 |
| `release/*` | Preparation branch for next release | 다음 출시 버전 준비 브랜치 |
| `develop` | Development branch for next release(Default branch) | 다음 출시 버전 개발 브랜치(기본 브랜치) |
| `feature/*` | Feature development branch | 기능 개발 브랜치 |

#### Work Process | 작업 프로세스
1. Branch `feature/*` from `develop`
   `feature/*` 브랜치는 `develop`에서 분기

2. Merge to `develop` after feature completion
   기능 개발 완료 후 `develop`으로 병합

3. Branch `release/*` from `develop` when ready for deployment
   배포 준비가 되면 `develop`에서 `release/*` 분기

4. Merge to `master` and `develop` after testing
   테스트 후 `master`와 `develop`으로 병합

5. Branch `hotfix/*` from `master` for bug fixes in release version
   출시 버전에서 버그 발생 시 `master`에서 `hotfix/*` 분기

6. Merge to `master` and `develop` after fix
   수정 후 `master`와 `develop`에 병합

#### Naming Convention | 네이밍 규칙
| Branch Type | Example | 예시 |
|-------------|---------|------|
| `feature/*` | feature/login | feature/login |
| `release/*` | release/v1.0.0 | release/v1.0.0 |
| `hotfix/*` | hotfix/v1.0.1 | hotfix/v1.0.1 |

## 🛠️ Git Configuration | Git 설정

### .gitignore
Optimized `.gitignore` settings for Swift/Xcode projects included:  
Swift/Xcode 프로젝트에 최적화된 `.gitignore` 설정이 포함되어 있습니다:

- Xcode user setting files | Xcode 사용자 설정 파일
- Build outputs | 빌드 결과물
- Dependency management files | 의존성 관리 파일
- System files | 시스템 파일
- etc... | 등...

Please refer to [.gitignore](.gitignore) file for details.  
자세한 내용은 [.gitignore](.gitignore) 파일을 참고해주세요.

### .gitattributes
Settings to prevent project file conflicts are included.  
프로젝트 파일의 충돌을 방지하기 위한 설정이 포함되어 있습니다.

## 🚀 Getting Started | 시작하기

### How to Use | 사용 방법
1. Create new repository using this template
   이 템플릿을 사용하여 새 레포지토리 생성
   ```bash
   gh repo create [repository-name] --template [this-template-URL]
   ```
   Or click "Use this template" button on GitHub
   또는 GitHub에서 "Use this template" 버튼 클릭

2. Set branch protection rules
   브랜치 보호 규칙 설정
   - Protect `main`, `develop` branches | `main`, `develop` 브랜치 보호
   - Required PR | PR 필수
   - Required review approval | 리뷰 승인 필수

3. Modify templates for your project
   프로젝트에 맞게 템플릿 수정
   - Customize issue templates | 이슈 템플릿 커스터마이징
   - Modify PR templates | PR 템플릿 수정
   - Adjust branch strategy | 브랜치 전략 조정

## ⚠️ Disclaimer | 참고사항

This template is provided as a reference for GitHub repository setup.  
You can freely reference and modify for your project.  
However, we do not guarantee the completeness or accuracy of this template, and the responsibility for its use lies with the user.

이 템플릿은 GitHub 레포지토리 설정을 위한 참고용으로 제공됩니다.  
귀하의 프로젝트에 대해 자유롭게 참조하고 수정할 수 있습니다.  
단, 이 템플릿의 완성도나 정확성을 보장하지 않으며, 사용에 따른 책임은 사용자에게 있습니다.
