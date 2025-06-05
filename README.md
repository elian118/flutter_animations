# flutter_animations

Flutter animation examples.

## Packages and sites

- [Lottie](https://pub.dev/packages/lottie/install)
  - 애플터이펙트로 만든 움직이는 아이콘 표현을 도와주는 플러터 패키지. 
  - 플러터에서 자체 제공하는 AnimatedIcon 위젯만으로는 사용 가능한 아이콘이 매우 적다. 맘에 드는 애니메이션 여기서 아이콘을 찾을 수 없다면 Lottie 패키지에서 도움을 받아라.
- [LotteFiles](https://lottiefiles.com/)
  - Lottie로 사용 가능한 아이콘 파일을 제공하는 커뮤니티 사이트(부분 유료, 회원가입 필요)
- [Rive](https://rive.app/)
  - 다양한 플랫폼에서 사용 가능한 애니메이션 제작 도구를 제공하는 사이트(회원가입 필요)
- [Rive - marketplace](https://rive.app/marketplace/)
  - 다른 사람들이 제작한 Rive 애니메이션을 보고 내려받을 수 있는 곳(부분 유료)
  - 애니메이터가 제작한 애니메이션 `riv` 파일을 플러터에서 제어하려면 해당 파일에서 제공하는 상태 및 속성키와 값들을 확인하고 [rive](https://pub.dev/packages/rive/install) 패키지를 사용해 플러터와 이들을 연결해야 한다.
  - Rive로 제작된 파일은 읽기 전용으로 완성본이 배포된 `riv`와 편집 가능한 상태의 `rev` 두 가지로 구분된다. 개발에 사용 가능한 파일은 `riv`이며, 이 파일은 `rive editor`로도 내용 확인 또는 수정이 불가하다.
  - 마켓플레이스에서는 애니메이션 상세보기 페이지에서 볼 수 있는 Preview in Rive 버튼을 눌러 `rive editor`를 통해 해당 `rev` 파일의 내용을 확인할 수 있다.
- [flutter_animate](https://pub.dev/packages/flutter_animate)
  - 컨트롤러, 트윈 등의 애니메이션 보일러 플레이트 코드 없이 쉽게 플러터 애니메이션을 구현할 수 있도록 지원하는 아주 유명한 패키지. 보통을 이걸 쓴다.