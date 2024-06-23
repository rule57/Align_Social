import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CameraView2Controller {
        return CameraView2Controller()
    }
    
    func updateUIViewController(_ uiViewController: CameraView2Controller, context: Context) {}
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
