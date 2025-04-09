import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HeaderView()
            PetSelectionView()
            HappinessScoreView()
            BarkCoinsView()
            ActionButtonsView()
            Spacer()
            BottomNavBar()
        }
        .padding()
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text("Good evening, Alex!")
                    .font(.headline)
                Text("January 07, 2025")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "bell.badge")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

struct PetSelectionView: View {
    var body: some View {
        HStack {
            Image(systemName: "dog")
            Text("Kimchi")
                .font(.headline)
            Spacer()
            Image(systemName: "chevron.down")
        }
    }
}

struct HappinessScoreView: View {
    var body: some View {
        VStack {
            Text("Happiness Score")
                .font(.headline)
                .padding(.top)
            ZStack {
                Circle()
                    .trim(from: 0.0, to: 0.88)
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.blue]), startPoint: .leading, endPoint: .trailing), lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 150, height: 150)
                Text("88")
                    .font(.largeTitle)
                    .bold()
            }
            Image(systemName: "dog.fill") // Placeholder for pet image
                .resizable()
                .frame(width: 80, height: 80)
            Text("Up 3 points from yesterday!")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.1)))
    }
}

struct BarkCoinsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("BarkCoins")
                .font(.headline)
            ProgressView(value: 78, total: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
            Text("22 more points until next reward")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct ActionButtonsView: View {
    var body: some View {
        VStack {
            Button(action: {}) {
                HStack {
                    Text("Need Care Advice? Ask Here")
                    Spacer()
                    Image(systemName: "arrow.up.circle.fill")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
            }
            Button(action: {}) {
                HStack {
                    Text("Reach Out to Kimchi’s Crew!")
                    Spacer()
                    Image(systemName: "paperplane.fill")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.2)))
            }
        }
        .padding(.vertical)
    }
}

struct BottomNavBar: View {
    var body: some View {
        HStack {
            Image(systemName: "house.fill")
            Spacer()
            Image(systemName: "pawprint")
            Spacer()
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
            Spacer()
            Image(systemName: "leaf")
            Spacer()
            Image(systemName: "ellipsis")
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
